Pixtory.LocationManager = {

  lat: null,
  lng: null,

  // Are we allowed to process locations?
  allowsLocation: true,

  init: function() {
    this.updateLocation();
  },

  setCoordinates: function(coordinates) {
    this.lat = coordinates.latitude;
    this.lng = coordinates.longitude;
    console.log("Set coords to", this.lat, "and", this.lng);
    // TODO: Broadcast an even here.
  },

  updateLocation: function() {
    var self = this;
    navigator.geolocation.getCurrentPosition(function(result) {
      // On success, do something...
      console.log(result)
      self.setCoordinates(result.coords);
      self.allowsLocation = true;
    }, function() {
      self.allowsLocation = false;
    });
  }


};