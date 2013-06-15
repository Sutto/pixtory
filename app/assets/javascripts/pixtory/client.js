Pixtory.Client = {

  fetchRenderedMoments: function(lat, lng, page) {
    var paginated;
    var options = {lat: lat, lng: lng}
    if(page == undefined) {
      paginated = false;
    } else {
      paginated = true;
      options.page = page;
    }
    var promise = $.get("/explore?" + $.param(options));
    return promise.pipe(function(result) {
      var moments = $(result).filter('#moments');
      return {
        type:      moments.data('moment-type'),
        moments:   moments.find('.moment'),
        paginated: paginated
      }
    });
  }

};