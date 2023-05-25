Rails.application.config.middleware.use(OmniAuth::Builder) do
  provider(
    :procore,
      Rails.application.credentials.procore_omniauth.production.client_id,
      Rails.application.credentials.procore_omniauth.production.client_secret,
    client_options: {
      site: ENV.fetch("PROCORE_BASE_API_PATH", "https://api.procore.com"),
      api_site: ENV.fetch("PROCORE_BASE_API_PATH", "https://api.procore.com"),
    },
  )
end

OmniAuth.config.allowed_request_methods = [:get, :post]
