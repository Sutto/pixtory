class DumpContext  < AbstractController::Base

  include AbstractController::Rendering
  include AbstractController::Helpers
  include AbstractController::Translation
  include AbstractController::AssetPaths
  include Rails.application.routes.url_helpers

  default_url_options[:host] = (ENV['HOST'] || "pixtory.dev")

  self.view_paths = "app/views"

  def render_template(name, moment)
    @moment = moment
    render template: "dumps/#{name}"
  end

end
