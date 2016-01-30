require 'colorize'
require 'json'
require_relative 'bitstamp'
require_relative 'kraken'
require_relative 'bitmex'

class Prices

  class Persister

    BTC = :btc
    ETH = :eth

    def initialize
      load
    end

    def get(crypto)
      @prices[crypto.to_s] && @prices[crypto.to_s].to_f
    end

    def set(crypto, price)
      @prices[crypto.to_s] = price
      save
    end

    def get_change(crypto, current_price)
      if old_price = self.get(crypto) and old_price
        if current_price > old_price
          percentage_increase = 100 * (current_price - old_price) / old_price
          return " (+#{'%2.1f' % percentage_increase}%)".green if (percentage_increase * 10).round / 10 > 0
        elsif current_price < old_price
          percentage_decrease = 100 * (old_price - current_price) / old_price
          return " (-#{'%2.1f' % percentage_decrease}%)".red if (percentage_decrease * 10).round / 10 > 0
        end
      end
      " (=)".green
    end

  private

    def file
      File.join(File.dirname(__FILE__), 'prices.json')
    end

    def save
      File.open(file, 'w') { |f| f.puts(@prices.to_json) }
    end

    def load
      @prices ||= File.exists?(file) ? JSON.parse(File.read(file)) : {}
    end

  end

  def prices
    @persister ||= Persister.new
  end

  def convert_usd_eur(usd)
    bitstamp.convert_usd_eur(usd)
  end

  def btc_price
    bitstamp.price_usd
  end

  def eth_price
    kraken.price_usd
  end

  def show
    puts "BTC".green
    print "Bitstamp: $#{bitstamp.price_usd}"
    print " #{'%.2f' % bitstamp.price_eur}€".yellow
    puts prices.get_change(:btc, bitstamp.price_usd)
    prices.set(:btc, bitstamp.price_usd)

    # bitmex = Bitmex.new
    # puts
    # puts "Bitmex".green
    # puts "Mark: $#{bitmex.mark_price}"
    # puts "Bid XBT24H: $#{bitmex.bid_price}"
    # puts "Ask XBT24H: $#{bitmex.ask_price}"

    puts

    puts "ETH".green
    print "Kraken: $#{'%.2f' % kraken.price_usd}"
    print " #{'%.2f' % kraken.price_eur}€".yellow
    print " #{'%.2f' % kraken.price_gbp}£".yellow
    puts prices.get_change(:eth, kraken.price_usd)
    prices.set(:eth, kraken.price_usd)
  end

private

  def bitstamp
    @bitstamp ||= Bitstamp.new
  end

  def kraken
    @kraken ||= Kraken.new
  end

end
