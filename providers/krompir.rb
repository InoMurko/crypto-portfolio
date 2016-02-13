require_relative 'connection'

class Krompir

  API_BASE = "https://bitcells.com/api"

  def krm_to_usd
    1
  end

  def krm_to_btc
    1
  end

private

  def conn
    @conn ||= FakeConnection.new(API_BASE) { |conn| }
  end

end
