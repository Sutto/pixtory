class MomentsController < ApplicationController

  def show
    moment = Moment.find(params[:id])
    render json: moment
  end

  def index
    lat, lng = params[:lat], params[:lng]
    if lat.blank? or lng.blank?
      render json: {error: "Missing lat or lng"}, status: :bad_request
    end
    distance = [[(params[:distance].presence || 500).to_i, 5000].min, 50].max
    moments = Moment.near(lat, lng, distance).page(params[:page]).per_page(25)
    render json: moments
  end

end
