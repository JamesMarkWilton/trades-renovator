class ApplicationController < ActionController::Base
    def client
        @client ||= Procore::Client.new(
            client_id: Rails.application.credentials.procore_omniauth.production.client_id,
            client_secret: Rails.application.credentials.procore_omniauth.production.client_secret,
            store: Procore::Auth::Stores::Session.new(session: session)
        )
    end
end
