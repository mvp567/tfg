// no funciona el focus sobre el pac-input. crec q hi ha algo a sobre
$(document).ready(function(){
	/* Galeria fotos del PDI#show */
	$('.popup-gallery').magnificPopup({
		delegate: 'a',
		type: 'image',
		tLoading: 'La imatge s\'està carregant #%curr%...',
		mainClass: 'mfp-img-mobile',
		gallery: {
			enabled: true,
			navigateByImgClick: true,
			preload: [0,1] // Will preload 0 - before current, and 1 after the current image
		},
		image: {
			tError: '<a href="%url%">La imatge #%curr%</a> no s\'ha pogut carregar.',
			titleSrc: function(item) {
				return item.el.attr('title');
			}
		}
	});

	/* Interfície etiquetes de PDI#new,edit*/
	$("#etiquetes").tagit();

	/* Efecte colorejat en la creació de pdi PDI#new */
	$("#div_etiquetes").focusout(function() {
		$("#ph_3").removeClass("colorejat");
        $("#ph_4").addClass("colorejat");
	});
	 
});

