(function(P, $, undefined) {

  var self = P.MomentList = {};

  self.reLayout = function() {};

  var lastType = null;
  var lastPage = 0;
  var moments  = null;

  self.reset = function() {
    if(moments) moments.empty();
  };

  self.process = function(result) {
    if(result.type !== lastType) {
      self.reset();
      lastType = result.type;
      lastPage = 0;
    }
    self.add(result.moments);
    lastPage++;
  };

  self.loadNextPage = function() {
    self.loadNearbyPage(lastPage + 1);
  }

  self.loadNearbyPage = function(pageNumber) {
    P.fetchFromLocation(pageNumber).done(function(r) { self.process(r); });
  }

  self.add = function(children) {
    moments.append(children);
    MomentList.isotope('reLayout');
  };

  self.init = function() {
    moments = $('#moments');
    self.configureGrid();
    moments.delegate('.moment', 'click', function(e) {
      e.preventDefault();
      var current = $(this);
      var moment = $('<div />', {'class': 'moment expanded'}).append(current.find('.moment-full').clone());
      P.Overlay.show(moment);
    })
  };

  self.configureGrid = function() {
    moments.isotope({
      masonry: {columnWidth: 100, gutterWidth: 10}
    });
  }

})(Pixtory, jQuery);
