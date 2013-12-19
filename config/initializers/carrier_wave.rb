CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
        :provider               => 'AWS',                        # required
        :aws_access_key_id      =>  ENV['S3_KEY'],               # required
        :aws_secret_access_key  => ENV['S3_SECRET'],                        # required
        :region                 => 'eu-west-1',                  # optional, defaults to 'us-east-1'
        :host                   => 's3.example.com',             # optional, defaults to nil
        :endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
    }
    config.fog_directory  = 'filmbox'                     # required
  else
    config.storage = :file
    config.enable_processing = Rails.env.development?
  end

end