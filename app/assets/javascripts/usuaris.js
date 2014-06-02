$(document).ready(function() {
	getLocation();
	/* Agafar la geolocalització del browser */
	function getLocation()
	{
	  if (navigator.geolocation)
	  {
	    navigator.geolocation.getCurrentPosition(showPosition);
	  }
	  else{alert(  "Geolocation is not supported by this browser.");}
	}

	function showPosition(position)
	{
	  $("input[id$='coord_lat_browser']").val(position.coords.latitude);
	  $("input[id$='coord_lng_browser']").val(position.coords.longitude);
	}
});

