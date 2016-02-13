require_relative 'provider'

class Kraken

  API_BASE = "https://api.kraken.com/0/public/"

  def eth_to_usd
    @eth_to_usd ||= prices['XETHZUSD']['b'][0].to_f
  end

  def eth_to_btc
    @btc_to_eth ||= prices['XETHXXBT']['b'][0].to_f
  end

  def eth_to_eur
    @eth_to_usd ||= prices['XETHZUSD']['b'][0].to_f
  end

private

  def prices
    #return conn.get('Ticker', pair: 'ETHEUR, ETHUSD, ETHGBP, ETHXBT').body['result']
    @prices ||= conn.get('Ticker', pair: 'ETHEUR, ETHUSD, ETHGBP, ETHXBT').body['result']
  end

  def conn
    @conn ||= Provider.new(API_BASE).conn
  end

end
