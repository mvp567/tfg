function initialize() {
  var mapOptions = {
    center: new google.maps.LatLng(41.39147225212958, 2.1668240462890935),
    zoom: 7
  };
  var map = new google.maps.Map(document.getElementById('map-canvas'),
    mapOptions);

  var input = /** @type {HTMLInputElement} */(
      document.getElementById('pac-input'));

  var types = document.getElementById('type-selector');
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(types);

  var autocomplete = new google.maps.places.Autocomplete(input);
  autocomplete.bindTo('bounds', map);

  var infowindow = new google.maps.InfoWindow();
  var marker = new google.maps.Marker({
    map: map,
    anchorPoint: new google.maps.Point(0, -29)
  });

  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    infowindow.close();
    marker.setVisible(false);
    var place = autocomplete.getPlace();

    var tipus = $('#tipus').val().toLowerCase();

    $('#' + tipus + '_nom').val(place.name);
    $('#' + tipus + '_horari').val(place.opening_hours);
    $('#' + tipus + '_telefon').val(place.formatted_phone_number);
    $('#' + tipus + '_web').val(place.website);
    $('#' + tipus + '_nivell_preu').val(place.price_level);

    
    $('#' + tipus + '_adreca').val(place.formatted_address);
    $('#' + tipus + '_coord_lat').val(place.geometry.location.A);
    $('#' + tipus + '_coord_lng').val(place.geometry.location.k);
    


    //fillInAddress(tipus);

    for (var i = 0; i < place.address_components.length; i++) {
      var addressType = place.address_components[i].types[0];
      if (addressType == 'locality') {
        $('#' + tipus + '_localitat').val(place.address_components[i].long_name);
      }
      else if (addressType == 'country') {
        $('#' + tipus + '_pais').val(place.address_components[i].long_name);
      }
      else if (addressType == 'postal_code') {
        $('#' + tipus + '_codi_postal').val(place.address_components[i].long_name);
      }
  }
    
    if (!place.geometry) {
      return;
    }

    // If the place has a geometry, then present it on a map.
    if (place.geometry.viewport) {
      map.fitBounds(place.geometry.viewport);
    } else {
      map.setCenter(place.geometry.location);
      map.setZoom(17);  // Why 17? Because it looks good.
    }
    marker.setIcon(/** @type {google.maps.Icon} */({
      url: place.icon,
      size: new google.maps.Size(71, 71),
      origin: new google.maps.Point(0, 0),
      anchor: new google.maps.Point(17, 34),
      scaledSize: new google.maps.Size(35, 35)
    }));
    marker.setPosition(place.geometry.location);
    marker.setVisible(true);

    var address = '';
    if (place.address_components) {
      address = [
        (place.address_components[0] && place.address_components[0].short_name || ''),
        (place.address_components[1] && place.address_components[1].short_name || ''),
        (place.address_components[2] && place.address_components[2].short_name || '')
      ].join(' ');
    }

    infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
    infowindow.open(map, marker);
  });


  // Sets a listener on a radio button to change the filter type on Places
  // Autocomplete.
  function setupClickListener(id, types) {
    var radioButton = document.getElementById(id);
    google.maps.event.addDomListener(radioButton, 'click', function() {
      autocomplete.setTypes(types);
    });
  }

  setupClickListener('changetype-all', []);
  setupClickListener('changetype-establishment', ['establishment']);
  setupClickListener('changetype-geocode', ['geocode']);
}

google.maps.event.addDomListener(window, 'load', initialize);
