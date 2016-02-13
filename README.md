## Setup

    git clone git@github.com:davidhq/cryptonite-ruby.git
    cd cryptonite-ruby
    bundle

## Check current prices for Bitcoin and Ethereum

    ruby check.rb

## Add crypto portfolio holdings (BTC and ETH)

    cp config.yml.sample config.yml

    nano config.yml

    ruby check.rb

  and see your crypto net worth.

## Specify currencies for crypto (BTC and ETH) price check

Default is `usd`, but you can list `usd`, `eur` or `gbp` in config.yml.

Crypto prices will be listed in all of these and
first one is used to show the aggregate portfolio value.

## Currency converter

Can convert **any fiat currency** plus `btc` and `eth`.

    ruby convert.rb "100 usd in btc"

    ruby convert.rb "300 eur in eth"

    ruby convert.rb "500 cny in eur"

Setting `basis` (can be `usd` or `btc`) in `config.yml` indicates the basis currency for conversions.

Basis currency just means *the intermmediate*, if needed.

## Debugging

    touch .debug
