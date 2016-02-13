#!/usr/bin/env ruby
require 'colorize'
require_relative 'config'
require_relative 'currency'
require_relative 'currency_converter'
require_relative 'prices'
require_relative 'portfolio'

prices = Prices.new
basis = Config.load["basis"] || Currency::USD
converter = CurrencyConverter.new(basis)

# Show current prices and price changes

puts "BTC".green
print "Bitstamp: "
price = converter.ratio(Currency::BTC, Currency::USD).round
Currency.list.each_with_index do |currency, index|
  print " " unless index == 0
  converted = price * converter.ratio(Currency::USD, currency)
  output = "#{Currency.format(converted.round, currency)}"
  print index == 0 ? output.colorize(:yellow) : output
end
puts prices.get_change(Currency::BTC, converter)

if Config.load['futures']
  bitmex = Bitmex.new
  puts
  puts "Bitmex".green
  puts "Mark: $#{bitmex.mark_price}"
  puts "Bid XBT24H: $#{bitmex.bid_price}"
  puts "Ask XBT24H: $#{bitmex.ask_price}"
end

puts "\nETH".green
print "Kraken: "
price = converter.ratio(Currency::ETH, Currency::USD)
Currency.list.each_with_index do |currency, index|
  print " " unless index == 0
  converted = price * converter.ratio(Currency::USD, currency)
  output = Currency.format('%.2f' % converted, currency)
  print index == 0 ? output.colorize(:yellow) : output
end
puts prices.get_change(Currency::ETH, converter)

# Show portfolio

Portfolio.new.show(prices, converter)
