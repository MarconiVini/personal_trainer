// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs


$(document).ready(function() {
	$('#switcher a').click(function(e) {
		e.preventDefault();
		if($(this).hasClass('ico-col1')) {
			$(this).removeClass('ico-col1').addClass('ico-col2').attr('title', 'Mostrar Menu Principal');
			$('#aside').animate({
				width : 'toggle'
			});
			$('#content').css('margin-left', '15px');
		} else {
			$(this).removeClass('ico-col2').addClass('ico-col1').attr('title', 'Mostrar apenas uma coluna');
			$('#aside').animate({
				width : 'toggle'
			});
			$('#content').css('margin-left', '0');
		}
		//$(this).removeClass();
	});
	$('.msg.info').fadeIn(1000).delay(10000).fadeOut(3000);
	$('.msg.error').fadeIn(1000).delay(10000).fadeOut(3000);

	$('.UrlSugestao').data('textinput', $('.UrlSugestao').val());

	$('a.BtnSugestao').click(function(event) {
		event.preventDefault();
		url = $(this).find('span').html().trim();
		//remove todos os espaços em branco
		$('.UrlSugestao').removeAttr('disabled').val(url);
		$('.UrlSugestao').data('textinput', $('.UrlSugestao').val());
	});

	$('.UrlSugestao').blur(function() {
		//code to not allow any changes to be made to input field
		checkbox = $("#admin_autorizated");
		if(checkbox.attr('checked')) {
			return false;
		} else {
			$(this).val($(this).data('textinput'));
			return false;
		}
	});
});
