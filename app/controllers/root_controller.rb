class RootController < ApplicationController

  def index
    respond_to do |format|
      format.html { redirect_to explore_url }
      format.json do
        render json: {moments: moments_url}
      end
    end
  end

end
