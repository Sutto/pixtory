(function(P, $, undefined) {

  var self = P.LocationManager  = {};
  self.lat                      = null;
  self.lng                      = null;
  self.allowsLocation           = false;

  self.init = function() {
    self.updateLocation();
  };

  self.setCoordinates = function(coordinates) {
    self.lat = coordinates.latitude;
    self.lng = coordinates.longitude;
    console.log("Set coords to", self.lat, "and", self.lng);
    // TODO: Broadcast an even here.
  };

  self.updateLocation = function() {
    navigator.geolocation.getCurrentPosition(function(result) {
      // On success, do something...
      console.log(result)
      self.setCoordinates(result.coords);
      self.allowsLocation = true;
    }, function() {
      self.allowsLocation = false;
    });
  };

})(Pixtory, jQuery);
