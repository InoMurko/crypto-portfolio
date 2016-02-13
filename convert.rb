#!/usr/bin/env ruby
require 'readline'
require 'colorize'
require_relative 'config'
require_relative 'util'
require_relative 'currency'
require_relative 'currency_converter'

input = ARGV[0] ? ARGV[0] : Readline.readline("Query (ex. 50 usd in btc): ", true)
input.strip.downcase =~ /([\d\.]+)\s*(.*?)\s+(?:(?:in|to)\s+)?(.*?)$/

amount = $1.to_f
from = $2
to = $3

# log "Amount: #{amount}"
# log "From: #{from}"
# log "To: #{to}"

converter = CurrencyConverter.new(Config.load["basis"] || Currency::USD)
converted = amount * converter.ratio(from, to)
print "#{amount} #{from} = "
puts "#{'%0.2f' % converted} #{to}".yellow
