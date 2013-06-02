class MomentsController < ApplicationController

  def show
    moment = Moment.find(params[:id])
    render json: moment
  end

  def index
    lat, lng = params[:lat], params[:lng]
    random   = false
    moments  = nil
    if lat.present? && lng.present?
      distance = [[(params[:distance].presence || 500).to_i, 5000].min, 50].max
      moments = Moment.near(lat, lng, distance)
      moments = nil if moments.count.zero?
    end
    if moments.nil?
      moments = Moment.random
      random = true
    end
    render json: moments.page(params[:page]).per_page(25), metadata: {random: random}
  end

end
