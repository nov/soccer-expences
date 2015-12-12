if Rails.env.development?
  [Rack::OAuth2, FbGraph2].each do |gem|
    gem.logger = Rails.logger
    gem.debug!
  end
end