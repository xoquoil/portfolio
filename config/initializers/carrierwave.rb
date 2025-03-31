CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_provider = 'fog/google'
    config.fog_credentials = {
      provider: 'Google',
      google_json_key_string: ENV['GCS_CREDENTIALS'],
      google_project: 'maximal-journey-438210-q1'
    }
    config.fog_directory  = 'pinpoint-map'
  else
    config.storage = :file
    config.enable_processing = !Rails.env.test? # テスト環境では画像処理を無効化
  end
end