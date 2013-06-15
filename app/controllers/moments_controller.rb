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
    moments  = moment_fetcher.moments
    metadata = moment_fetcher.metadata
    respond_to do |format|
      format.json    { render json: moments, meta: metadata }
      format.geojson { render json: MomentGeoJsonSerializer.collection(moments, default_serializer_options), meta: metadata }
      format.kml     { render text: KmlFeedGenerator.render(moments) }
    end
  end

end
