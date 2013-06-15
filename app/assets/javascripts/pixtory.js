//= require_self
//= require pixtory/location_manager
//= require pixtory/moment_list
//= require pixtory/overlay
//= require pixtory/client

var Pixtory = {

  init: function() {
    this.Overlay.init();
    this.LocationManager.init();
    this.MomentList.init();
  },

  fetchFromLocation: function(page) {
    var location  = this.LocationManager;
    return this.Client.fetchRenderedMoments(location.lat, location.lng, page);
  }

};
