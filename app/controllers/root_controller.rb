class RootController < ApplicationController

  def index
    render json: {
      moments: moments_url
    }
  end

end
