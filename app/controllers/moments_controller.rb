class MomentsController < ApplicationController

  def show
    moment = Moment.preloaded.find(params[:id])
    render json: moment
  end

  def index
    moments = Moment.preloaded.all
    render json: moments
  end

end
