require_relative 'connection'

class Bitstamp

  API_BASE = "https://www.bitstamp.net/api/"

  def btc_to_usd
    @price_usd ||= conn.get('ticker/').body['last'].to_f
  end

  def eur_to_usd
    @ratio ||= conn.get('eur_usd/').body['buy'].to_f
  end

  # def price_eur
  #   @price_eur ||= convert_usd_eur(price_usd)
  # end

private

  def conn
    @conn ||= Connection.new(API_BASE) do |conn|
      conn.request :json
      conn.response :json, :content_type => /\bjson$/
      conn.adapter Connection.default_adapter
    end
  end

end
