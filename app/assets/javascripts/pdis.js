// no funciona el focus sobre el pac-input. crec q hi ha algo a sobre
$(document).ready(function(){

	$('.popup-gallery').magnificPopup({
		delegate: 'a',
		type: 'image',
		tLoading: 'Loading image #%curr%...',
		mainClass: 'mfp-img-mobile',
		gallery: {
			enabled: true,
			navigateByImgClick: true,
			preload: [0,1] // Will preload 0 - before current, and 1 after the current image
		},
		image: {
			tError: '<a href="%url%">The image #%curr%</a> could not be loaded.',
			titleSrc: function(item) {
				return item.el.attr('title') + '<small>by Marsel Van Oosten</small>';
			}
		}
	});
	$("#etiquetes").tagit();

	$("#div_etiquetes").focusout(function() {
		$("#ph_3").removeClass("colorejat");
        $("#ph_4").addClass("colorejat");
	});

	 
});

