require_relative 'providers/coinbase'
require_relative 'providers/bitstamp'
require_relative 'providers/kraken'
require_relative 'providers/coinfloor'
require_relative 'providers/poloniex'
require_relative 'currency'
require_relative 'util'

class CurrencyConverter

  def initialize(basis)
    log "Initialized currency converter based on #{basis}"
    @basis = basis.to_sym
  end

  def ratio(from, to)
    from = from.to_sym
    to = to.to_sym

    if from == to
      1
    elsif conv = conversions[@basis][[from, to]]
      log "Converted #{from} to #{to} via #{conv[0].class}"
      conv[1].call
    elsif conv = conversions[@basis][[to, from]]
      log "Converted #{from} to #{to} via #{conv[0].class}"
      1 / conv[1].call
    elsif ratio = coinbase.convert(from, to)
      log "Converted #{from} to #{to} via Coinbase"
      ratio
    else
      #log "Converting #{from}-#{@basis} AND #{@basis}-#{to}..."
      ratio(from, @basis) * ratio(@basis, to)
    end
  end

private

  # conversions are per basis,
  # has to provide all conversions either from- or -to basis
  def conversions
    @conversions ||= {
      Currency::USD => { # all conversions to or from USD
        [Currency::BTC, Currency::USD] => [bitstamp, lambda { bitstamp.btc_to_usd }],
        [Currency::EUR, Currency::USD] => [bitstamp, lambda { bitstamp.eur_to_usd }],
        [Currency::ETH, Currency::USD] => [kraken, lambda { kraken.eth_to_usd }]
      },
      Currency::BTC => { # all conversions to or from BTC
        [Currency::BTC, Currency::EUR] => [bitstamp, lambda { bitstamp.btc_to_eur }],
        [Currency::BTC, Currency::USD] => [bitstamp, lambda { bitstamp.btc_to_usd }],
        [Currency::ETH, Currency::BTC] => [kraken, lambda { kraken.eth_to_btc }]
      }
    }
  end

  def coinbase
    @coinbase ||= Coinbase.new
  end

  def bitstamp
    @bitstamp ||= Bitstamp.new
  end

  def coinfloor
    @coinfloor ||= Coinfloor.new
  end

  def krompir
    @krompir ||= Krompir.new
  end

  def kraken
    @kraken ||= Kraken.new
  end

  def poloniex
    @poloniex ||= Poloniex.new
  end

end
