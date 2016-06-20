require_relative 'provider'

class Bitmex

  API_BASE = "https://www.bitmex.com/api/v1/"

  def mark_price
    @mark_price ||= conn.get('instrument/indices').body[0]['markPrice']
  end
=begin
  def bid_price
    '%.2f' % bid_ask['bidPrice'].to_f
  end

  def ask_price
    '%.2f' % bid_ask['askPrice'].to_f
  end
=end
private

  def bid_ask
    @bid_ask ||= conn.get('orderBook', { symbol: 'XBT24H', depth: 1 }).body[0]
  end

  def conn
    @conn ||= Provider.new(API_BASE).conn
  end

end
