require_relative 'provider'

class Bitstamp

  API_BASE = "https://www.bitstamp.net/api/"

  def btc_to_usd
    @price_usd ||= conn.get('ticker/').body['last'].to_f
  end

  def btc_to_eur
    btc_to_usd / eur_to_usd
  end

  def eur_to_usd
    @ratio ||= conn.get('eur_usd/').body['buy'].to_f
  end

private

  def conn
    @conn ||= Provider.new(API_BASE).conn
  end

end
