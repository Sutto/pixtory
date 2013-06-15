class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :moment_fetcher

  private

  def default_serializer_options
    {
      controller: self
    }
  end

  def moment_fetcher
    @moment_fetcher ||= MomentFetcher.new(params.slice(:lat, :lng, :page, :distance))
  end

end
