if (api_key = ENV["HONEYBADGER_API_KEY"] || Rails.application.credentials.dig(:honeybadger, :api_key))
  Honeybadger.configure do |config|
    config.api_key = api_key
  end
end
