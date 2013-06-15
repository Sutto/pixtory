class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :moment_fetcher

  layout :computed_layout

  private

  def default_serializer_options
    {
      controller: self
    }
  end

  def moment_fetcher
    @moment_fetcher ||= MomentFetcher.new(params.slice(:lat, :lng, :page, :distance))
  end

  private

  def computed_layout
    if request.xhr?
      return false
    else
      return "application"
    end
  end

end
