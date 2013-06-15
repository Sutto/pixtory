//= require_self
//= require pixtory/location_manager
//= require pixtory/client

var Pixtory = {

  lastType: null,
  lastPage: null,

  init: function() {
    console.log("Taking over the world...");
    this.LocationManager.init();
  },

  renderMoments: function(moments) {
    var container = $('#moments');
    console.log("Rendering", moments);
    if(this.lastType == null || this.lastType != moments.type) {
      this.lastType = moments.type;
      container.empty();
    }
    container.append(moments.moments);
  },

  fetchFromLocation: function(page) {
    this.lastPage = page;
    var location  = this.LocationManager;
    var query     = this.Client.fetchRenderedMoments(location.lat, location.lng);
    var self      = this;
    query.done(function(result) {
      self.renderMoments(result);
    });
  }

};
