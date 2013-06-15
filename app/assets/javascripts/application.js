//= require jquery
//= require jquery_ujs
//= require jquery.ui.core
//= require jquery.ui.effect
//= require ./jquery.isotope.min
//= require ./isotope.overrides
//= require ./pixtory

$(function() {

  // var moments = $('#moments');

  // moments.isotope({
  //   masonry: {
  //     columnWidth: 100,
  //     gutterWidth: 10
  //   }
  // });

  // moments.on("click", ".moment", function() {
  //   var elem = $(this);
  //   if(elem.hasClass('expanded')) {
  //     elem.removeClass('expanded', 100, function() { moments.isotope('reLayout'); });
  //   } else {
  //     $('#moments .moment').removeClass('expanded', 100);
  //     elem.addClass('expanded', 100, function() { moments.isotope('reLayout'); });
  //   }
  // });

  Pixtory.init();

});
