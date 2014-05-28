// no funciona el focus sobre el pac-input. crec q hi ha algo a sobre
window.onload = function() {
  var input = document.getElementById("pac-input").focus();
}

$(document).ready(function(){

	$('#etiquetes').focusout(function() {
		$("#ph_3").removeClass("coloreate");
        $("#ph_4").addClass("coloreate");
	});

	// no funciona el selectize a etiquetes
	$('#input-tags').selectize({
	    delimiter: ',',
	    persist: false,
	     maxItems: 1,
	    create:true,
	    options: items,
	    labelField: "item",
	    valueField: "item",
	    searchField: "item",
	    create: function(input) {
	        return {
	            value: input,
	            text: input
	        }
	    }
	});
});