class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def default_serializer_options
    {
      controller: self
    }
  end

end
