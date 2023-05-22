class ApplicationController < ActionController::Base
    def client
        @client ||= Procore::Client.new(
            client_id: Rails.application.credentials.production.procore.access_key_id,
            client_secret: Rails.application.credentials.production.procore.secret_access_key,
            store: Procore::Auth::Stores::Session.new(session: session)
        )
    end
end
