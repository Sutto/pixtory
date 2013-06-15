(function(P, $, undefined) {

  var self = P.Overlay = {};

  var overlay = null, content = null, background = null, inner = null;

  self.init = function() {
    overlay = $('#moment-overlay');
    content = overlay.find('#overlay-inner');
    background = overlay.find('#overlay-background');

    overlay.click(function(e) {
      e.preventDefault();
      self.hide();
    });

    content.click(function(e) { e.stopPropagation(); });

    $(window).resize(function() { self.reposition(); });

  }

  self.show = function(toShow) {
    overlay.show();
    content.append(toShow);
    inner = toShow;
    self.reposition();
  };

  self.hide = function() {
    overlay.hide();
    content.empty();
    inner = null;
  }

  self.reposition = function() {
    if(inner === null) return;
    // overlay.width(inner.width() + 'px').height(inner.height() + 'px');
    var top = Math.max(0, (overlay.height() - inner.height()) / 2);
    var left = Math.max(0, (overlay.width() - inner.width()) / 2);
    content.css({'top': top + 'px', 'left': left + 'px'});
  };

})(Pixtory, jQuery);
