CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_provider = 'fog/google'
  config.fog_credentials = {
    provider: 'Google',
    google_json_key_string: ENV['GCS_CREDENTIALS'],
    google_project: 'maximal-journey-438210-q1'
  }
  config.fog_directory  = 'pinpoint-map'
end
