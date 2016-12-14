OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['299198517102709'], ENV['bf8e8bbe5e1479f48790c9d0ee298be3']
end