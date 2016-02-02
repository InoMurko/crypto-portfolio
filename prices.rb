require 'colorize'
require 'json'
require_relative 'bitstamp'
require_relative 'kraken'
require_relative 'bitmex'

class Prices

  BTC = :btc
  ETH = :eth

  class Persister

    def initialize
      load
    end

    def get(token)
      @prices[token.to_s] && @prices[token.to_s].to_f
    end

    def set(token, price)
      @prices[token.to_s] = price
      save
    end

  private

    FILE = File.join(File.dirname(__FILE__), 'prices.json')

    def save
      File.open(FILE, 'w') { |f| f.puts(@prices.to_json) }
    end

    def load
      @prices ||= File.exists?(FILE) ? JSON.parse(File.read(FILE)) : {}
    end

  end

  def get_change(token)
    current_price = price(token)
    msg = nil

    if old_price = persister.get(token) and old_price
      if current_price > old_price
        percentage_increase = 100 * (current_price - old_price) / old_price
        msg = " (+#{'%2.1f' % percentage_increase}%)".green if (percentage_increase * 10).round / 10 > 0
      elsif current_price < old_price
        percentage_decrease = 100 * (old_price - current_price) / old_price
        msg = " (-#{'%2.1f' % percentage_decrease}%)".red if (percentage_decrease * 10).round / 10 > 0
      end
    end

    persister.set(token, current_price)

    msg
  end

  def convert_usd_eur(usd)
    bitstamp.convert_usd_eur(usd)
  end

  def price(token)
    case(token)
      when BTC
        bitstamp.price_usd
      when ETH
        kraken.price_usd
    end
  end

private

  def bitstamp
    @bitstamp ||= Bitstamp.new
  end

  def kraken
    @kraken ||= Kraken.new
  end

  def persister
    @persister ||= Persister.new
  end

end
