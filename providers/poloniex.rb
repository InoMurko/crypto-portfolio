require_relative 'provider'

class Poloniex

  API_BASE = "https://poloniex.com/public"

  def eth_to_btc
    @eth_to_btc ||= prices.body['bids'][0][0].to_f
  end

private

  def prices
    @prices ||= conn.get('?command=returnOrderBook', currencyPair: 'BTC_ETH')
  end

  def conn
    @conn ||= Provider.new(API_BASE).conn
  end

end
