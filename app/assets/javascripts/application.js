// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require ../../../vendor/assets/javascripts/jquery-1.11.1
//= require ../../../vendor/assets/javascripts/jquery-ui-1.10.4

//= require ../../../vendor/assets/javascripts/bootstrap/js/bootstrap

//= require ../../../vendor/assets/javascripts/customdropdown/js/modernizr.custom.79639
//= require ../../../vendor/assets/javascripts/magnific-popup/js/jquery.magnific-popup
//= require ../../../vendor/assets/javascripts/tagit/js/tag-it
//= require ../../../vendor/assets/javascripts/rating/js/bootstrap-rating-input


//= require_tree .


function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

/*Codi pel customdropdown*/
$( document ).ready(function() {
  	$("li").on("click",function() {
      //$(".hidden").val($(event.target).text())
      $("#eo").val($(event.target).text());
      $("#seleccionat").val($(event.target).text());
 
  	});

	function DropDown(el) {
					this.dd = el;
					this.initEvents();
				}
				DropDown.prototype = {
					initEvents : function() {
						var obj = this;

						obj.dd.on('click', function(event){
							var dropDownValor = $('#dd').val();
							$('#seleccionat').val(dropDownValor);

							$(this).toggleClass('active');
							event.stopPropagation();
						});	
					}
				}

	$(function() {
		var dd = new DropDown( $('#dd') );

		$(document).click(function() {
		// all dropdowns
			$('.wrapper-dropdown-2').removeClass('active');
		});

	});

});