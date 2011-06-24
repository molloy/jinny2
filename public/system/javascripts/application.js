// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var showCenterPanelLoading = function() {
	$('#j-center').children().hide();
	$('#j-loading').show();
};

var hideCenterPanelLoading = function() {
	$('#j-loading').hide();
};

$(document).ready(function() {
	// create nav accordion
	if ($("#left_menu").length) {
		$("#left_menu").accordion({ header: 'h3', autoHeight: false });
		$("#left_menu").accordion('destroy').accordion({ header: 'h3', autoHeight: false });
	}

	// opening and closing panels
	$('.header').live('click', function() {
		var panel = $(this).next();
		if (panel.is(":visible")) {
			panel.hide("blind", {}, "fast", function() { $(this).prev().removeClass("ui-corner-top").addClass("ui-corner-all"); });
		} else {
			panel.show("blind", {}, "fast", function() { $(this).prev().removeClass("ui-corner-all").addClass("ui-corner-top"); });
		}
	});

	// resize window
	/*
	$(window).resize(function() {
		if ($('#j-login')) {
			$('#j-login').css({
				position:'absolute',
				left: ($(window).width() - $('#j-login').outerWidth())/2,
				top: ($(window).height() - $('#j-login').outerHeight() - 94)/2
			});
		}

		if ($('#j-center')) {
			$('#j-center').css({
				width: $(window).width() - $('#j-links').outerWidth()
			});
		}

	});
	
	$(window).resize();
	*/

	// delete for nested attributes
	$('#nested-models fieldset ol :input[type="button"]').live('click', function() {
		if ($(this).parent().prev().is("input")) {
			$(this).parent().parent().parent().hide();
			$(this).parent().prev().val("true");
		} else {
			$(this).parent().parent().parent().remove();
		}
	});
});
