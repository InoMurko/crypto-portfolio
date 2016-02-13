require_relative "connection"

class Provider

  def initialize(api_base)
    @api_base = api_base
  end

  def conn
    Connection.new(@api_base) { |conn| }
  end

end
