require 'omniauth'
require 'procore'

class LoginController < ApplicationController
  protect_from_forgery with: :null_session
  
  def index
  end

  def callback
    auth_hash = request.env['omniauth.auth']["credentials"]
    return redirect_to "/auth/procore" if auth_hash.blank?
      
    token = Procore::Auth::Token.new(
      access_token: auth_hash["token"],
      refresh_token: auth_hash["refresh_token"],
      expires_at: auth_hash["expires_at"]
    )

    store = Procore::Auth::Stores::Session.new(session: session)
    store.save(token)

    redirect_to new_trade_path
  end
end
