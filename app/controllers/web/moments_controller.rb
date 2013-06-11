class Web::MomentsController < ApplicationController

  def index
    @moments = Moment.all
    @page_title = "All of Pixtory"
  end

  def show
    @moment     = Moment.find(params[:id])
    @page_title = @moment.location
  end

end
