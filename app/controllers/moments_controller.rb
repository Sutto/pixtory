class MomentsController < ApplicationController

  def show
    moment = Moment.find(params[:id])
    respond_to do |format|
      format.json    { render json: moment }
      format.geojson { render json: moment, serializer: MomentGeoJsonSerializer }
      format.kml     { render text: KmlFeedGenerator.render([moment]) }
    end
  end

  def index
    fetcher = MomentFetcher.new params.slice(:lat, :lng, :page, :distance)
    respond_to do |format|
      format.json    { render json: fetcher.moments, meta: fetcher.metadata }
      format.geojson { render json: MomentGeoJsonSerializer.collection(fetcher.moments, default_serializer_options), meta: fetcher.metadata }
      format.kml     { render text: KmlFeedGenerator.render(fetcher.moments) }
    end
  end

end
