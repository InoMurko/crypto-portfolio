require 'faraday'
require 'faraday_middleware'

class Coinfloor

  API_BASE = "https://webapi.coinfloor.co.uk:8090/bist/"

  def price_usd
    @price_usd ||= conn.get('XBT/USD/ticker/').body['last'].to_f
  end

  def price_gbp
    @price_gbp ||= conn.get('XBT/GBP/ticker/').body['last'].to_f
  end

  def convert_usd_gbp(usd)
    usd * price_gbp / price_usd
  end

private

  def conn
    @conn ||= Faraday.new(API_BASE) do |conn|
      conn.request :json
      conn.response :json, :content_type => /\bjson$/
      conn.adapter Faraday.default_adapter
    end
  end

end