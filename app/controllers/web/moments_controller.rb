class Web::MomentsController < ApplicationController

  def index
    @page_title = "Explore your Pixtory"
  end

  def show
    @moment     = Moment.find(params[:id])
    @page_title = @moment.location
  end

end
