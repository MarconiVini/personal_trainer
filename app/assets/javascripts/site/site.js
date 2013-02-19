$(document).ready(function() {
	$('.BotaoLogin').click(function(event) {
		event.stopPropagation();
		$('.LoginTab .Content.BoxShadow').hide();
		$('.LoginTab .Content.BoxShadow').slideDown(600);
	});
	$('.LoginTab .Content').click(function(event) {
		event.stopPropagation();	
	});
	$('html').click(function() {
		$(".LoginTab .Content").hide();
	});
});

