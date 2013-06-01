if (bugsnag_key = ENV['BUGSNAG_API_KEY']).present?
  require 'bugsnag'
  Bugsnag.configure do |config|
    config.api_key = bugsnag_key
  end
end