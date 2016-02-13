require_relative 'provider'

class Coinfloor

  API_BASE = "https://webapi.coinfloor.co.uk:8090/bist/"

  def gbp_to_usd
    price_usd / price_gbp
  end

  def btc_to_gbp
    price_gbp
  end

private

  def price_usd
    @price_usd ||= conn.get('XBT/USD/ticker/').body['last'].to_f
  end

  def price_gbp
    @price_gbp ||= conn.get('XBT/GBP/ticker/').body['last'].to_f
  end

  def conn
    @conn ||= Provider.new(API_BASE).conn
  end

end
