Rails.application.config.middleware.use(OmniAuth::Builder) do
  provider(
    :procore,
    Rails.application.credentials.production.procore.access_key_id,
    Rails.application.credentials.production.procore.secret_access_key,
    client_options: {
      site: ENV.fetch("PROCORE_BASE_API_PATH", "https://api.procore.com"),
      api_site: ENV.fetch("PROCORE_BASE_API_PATH", "https://api.procore.com"),
    },
  )
end

OmniAuth.config.allowed_request_methods = [:get, :post]
