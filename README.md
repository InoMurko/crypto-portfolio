## Setup

    git clone git@github.com:davidhq/crypto-portfolio.git
    cd crypto-portfolio
    bundle

## Check current prices.

    ruby check.rb

## Add holdings

  Add amount of your holdings and see your crypto net worth.

    cp config.yml.sample config.yml

    nano config.yml

    ruby check.rb

## Specify currencies

Default is *usd*, but you can list *usd*, *eur*, *gbp* in config.yml - crypto prices will be listed in all of these and
first one is used to show the aggregate portfolio value.

### Example

![Screen](http://cl.ly/3E0g2T0c3i2W/Screen%20Shot%202016-02-04%20at%2011.36.24.png)


## Currency converter

    ruby convert.rb "30 eur in btc"

### Example

![Screen](http://cl.ly/3I3W0a421T2F/Image%202016-02-08%20at%205.51.40%20PM.png)
