class Web::MomentsController < ApplicationController

  def index
    @moments = Moment.all
  end

  def show
    @moment = Moment.find(params[:id])
  end

end
