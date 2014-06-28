function initialize() {
    if ($('#accio').val() == "creant") {
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

        $("#ph_2").removeClass("colorejat");
        $("#ph_3").addClass("colorejat");

        infowindow.close();
        marker.setVisible(false);
        var place = autocomplete.getPlace();

        var tipus = $('#tipus').val().toLowerCase();

        $('#' + tipus + '_nom').val(place.name);
        $('#' + tipus + '_horari').val(JSON.stringify(place.opening_hours));
        $('#' + tipus + '_telefon').val(place.formatted_phone_number);
        $('#' + tipus + '_web').val(place.website);
        $('#' + tipus + '_nivell_preu').val(place.price_level);
        $('#' + tipus + '_icone').val(place.icon);
        $('#' + tipus + '_place_reference').val(place.reference);
       
        // BEGIN tractament de place.photos per a guardar-ho serialitzat
        var string_fotos_petites = "";
        var string_fotos_grans = "";
        
        for (var i=0; i<place.photos.length; i++) {
          string_fotos_petites += place.photos[i].getUrl({ 'maxWidth': 75, 'maxHeight': 75 }) +",";
          string_fotos_grans += place.photos[i].getUrl({ 'maxWidth': 600, 'maxHeight': 600 }) +","; 
        }

        $('#' + tipus + '_fotos_petites').val(string_fotos_petites);
        $('#' + tipus + '_fotos_grans').val(string_fotos_grans);

        // END tractament de place.photos per a guardar-ho serialitzat


        $('#' + tipus + '_adreca').val(place.formatted_address);
        $('#' + tipus + '_coord_lat').val(place.geometry.location.k);
        $('#' + tipus + '_coord_lng').val(place.geometry.location.A);
        

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

  else if ($('#accio').val() == "editant") {
    var tipus = $('#tipus').val().toLowerCase();
    var lat = $('#' + tipus + '_coord_lat').val();
    var lng = $('#' + tipus + '_coord_lng').val();
    var myLatlng = new google.maps.LatLng(lat,lng);
    var mapOptions = {
      zoom: 16,
      center: myLatlng
    }

    $("#map-canvas").empty();
    var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

    /*var marker = new google.maps.Marker({
      position: myLatlng,
      title:"Hello World!"
    });

    // To add the marker to the map, call setMap();
    marker.setMap(map);*/

    /* BEGIN carregant detalls del place */
    var request = {
    reference: $('#' + tipus + '_place_reference').val()
    };

    /*service = new google.maps.places.PlacesService(map);
    service.getDetails(request, callback);

    function callback(place, status) {
      if (status == google.maps.places.PlacesServiceStatus.OK) {
        createMarker(place);
      }
    }*/

    var infowindow = new google.maps.InfoWindow();
    var service = new google.maps.places.PlacesService(map);

    service.getDetails(request, function(place, status) {
      if (status == google.maps.places.PlacesServiceStatus.OK) {
        var marker = new google.maps.Marker({
          map: map,
          position: place.geometry.location
        });
        google.maps.event.addListener(marker, 'click', function() {
          infowindow.setContent(place.name + '<br>' + place.formatted_address);
          infowindow.open(map, this);
        });
      }
    });
  /* END carregant detalls del place */

  }
  else if ($('#accio').val() == "mostrant") {
    var lat = $('#coord_lat').val();
    var lng = $('#coord_lng').val();
    var myLatlng = new google.maps.LatLng(lat,lng);
    var mapOptions = {
      zoom: 16,
      center: myLatlng
    }

    $("#map-canvas").empty();
    var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

   /* var marker = new google.maps.Marker({
      position: myLatlng,
      title:"Hello World!"
    });

    // To add the marker to the map, call setMap();
    marker.setMap(map);*/

    /* BEGIN carregant detalls del place */
    var request = {
    reference: $('#place_reference').val()
    };

    /*service = new google.maps.places.PlacesService(map);
    service.getDetails(request, callback);

    function callback(place, status) {
      if (status == google.maps.places.PlacesServiceStatus.OK) {
        createMarker(place);
      }
    }*/

    var infowindow = new google.maps.InfoWindow();
    var service = new google.maps.places.PlacesService(map);

    service.getDetails(request, function(place, status) {
      if (status == google.maps.places.PlacesServiceStatus.OK) {
        var marker = new google.maps.Marker({
          map: map,
          position: place.geometry.location
        });
        google.maps.event.addListener(marker, 'click', function() {
          infowindow.setContent(place.name + '<br>' + place.formatted_address);
          infowindow.open(map, this);
        });
      }
    });
/* END carregant detalls del place */

  }
  else if ($('#accio').val() == "creant_rt") {
    //var map;
      var mapOptions = {
        zoom: 1,
        center: new google.maps.LatLng(-34.397, 150.644)
      };
      window.map = new google.maps.Map(document.getElementById('map-canvas'),
          mapOptions);
  }
  else if ($('#accio').val() == "editant_rt") {
    directionsService = new google.maps.DirectionsService();
    directionsDisplay = new google.maps.DirectionsRenderer({
      suppressMarkers: true
    });
    var mapOptions = {
        zoom: 1,
        center: new google.maps.LatLng(-34.397, 150.644)
      };
      window.map = new google.maps.Map(document.getElementById('map-canvas'),
          mapOptions);

    var markersCoordinates = [];
    var waypointslatlng = [];
    var i = 0;

    // ini
    var infowindow = new google.maps.InfoWindow();
    var locations = [];

    $("li").each(function(index, value) {
      var lat = $(value).children( "input[id$='lat']" ).val();
      var lng = $(value).children( "input[id$='lng']" ).val();
    
      var myLatlng = new google.maps.LatLng(lat,lng);

      if (lat != null && lng != null) {
        markersCoordinates.push(myLatlng);
        waypointslatlng.push({
          location: myLatlng,
          stopover: true});

        locations.push([$(value).children( "input[id$='nompdi']" ).val(), lat, lng]);
      }

      
  
      
    }); // end li each


    // posa markers a cada PDI i amb el nom correcta
    var marker, i;

    for (i = 0; i < locations.length; i++) {  
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(locations[i][1], locations[i][2]),
        map: window.map
      });

      google.maps.event.addListener(marker, 'click', (function(marker, i) {
        return function() {
          infowindow.setContent(locations[i][0]);
          infowindow.open(window.map, marker);
        }
      })(marker, i));
    }



    // això dibuixa la ruta-direccions al mapa
    directionsDisplay.setMap(window.map);

    // esborrant el primer i últim pq ja estaran com origin i destination
    markersCoordinates.splice(0,1);
    markersCoordinates.splice(markersCoordinates.length-1,1);

    var request = {
        origin: new google.maps.LatLng(markersCoordinates[0]["k"], markersCoordinates[0]["A"]),
        destination: new google.maps.LatLng(markersCoordinates[markersCoordinates.length-1]["k"], markersCoordinates[markersCoordinates.length-1]["A"]),
        waypoints: waypointslatlng,
        travelMode: google.maps.TravelMode.WALKING
    };
    directionsService.route(request, function(response, status) {
        if (status == google.maps.DirectionsStatus.OK) {
            directionsDisplay.setDirections(response);
        }
    });



    /* línia de punt a punt funciona */
  /*var rutaMarkers = new google.maps.Polyline({
    path: markersCoordinates,
    geodesic: true,
    strokeColor: '#ed9577',
    strokeOpacity: 1.0,
    strokeWeight: 2
  });
    rutaMarkers.setMap(window.map);*/
}
}
google.maps.event.addDomListener(window, 'load', initialize);


