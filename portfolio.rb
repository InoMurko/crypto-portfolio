require_relative 'config'

class Portfolio

  def show(prices, converter)
    if config = Config.load['crypto']

      total = 0
      puts "\nTotal".green

      sums = {}

      for currency in config.keys
        if cur = config[currency]
          sums[currency] = cur['amount'].to_f * converter.ratio(currency.to_sym, Currency.default)
          total += sums[currency]
        end
      end

      if total > 0
        for currency in config.keys
          puts "#{currency.to_s.upcase}: #{Currency.format(sums[currency].round)} (#{(100.0 * sums[currency] / total).round}%)" if sums[currency]
        end
        puts "Sum: #{Currency.format(total.round)}".yellow
        puts "Invested: #{Config.load['invested']}".yellow
        invested = total.round - Config.load['invested'].split('£')[0].to_i
        puts "Diff: #{invested}£".yellow
      end
    end
  end

end
