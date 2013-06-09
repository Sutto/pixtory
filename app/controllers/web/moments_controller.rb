class Web::MomentsController < ApplicationController

  def index
    @moments = Moment.all
  end

end
