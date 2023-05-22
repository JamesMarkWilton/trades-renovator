require 'procore'

class TradesController < ApplicationController
  protect_from_forgery with: :null_session

  def new
  end

  def create
    begin
      params.require(:company_id)
      company_trades = client.get("companies/#{params[:company_id]}/trades").body.pluck(:name)
    rescue Procore::Error => error
      return redirect_to new_trade_path, flash: { error: error.message }
    rescue ActionController::ParameterMissing => error
      return redirect_to new_trade_path, flash: { error: 'Company ID is required to add Trades please enter a valid ID and try again' }
    end

    procore_trades = JSON.parse(File.read("#{Rails.root}/public/trades.json"))
    undefined_trades = procore_trades.reject { |trade_name| company_trades.include?(trade_name) }

    undefined_trades.each { |trade_name|
      next if company_trades.include?(trade_name)

      begin
        trade_info = { trade: { name: trade_name, active: true } }
        
        Thread.new do
          client.post("companies/#{params[:company_id]}/trades", body: trade_info)
        end
      rescue Procore::Error
        puts "Error'd on #{trade_name}"
        next
      end
    }

    flash.notice = "We have successfully added all possible Procore Approved Trades please check your Customer's Procore Admin Page"
    render new_trade_path
  end
end
