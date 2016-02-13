require 'faraday'
require 'faraday_middleware'

class Connection

  def initialize(api_base, &block)
    @api_base = api_base
    @conn = Faraday.new(api_base, &block)
    @conn.request :json
    @conn.response :json, :content_type => /\bjson$/
    @conn.adapter Connection.default_adapter
  end

  def self.default_adapter
    Faraday.default_adapter
  end

  def get(path, options = {})
    @conn.get(path, options)
  end

end

class FakeConnection

  def initialize(api_base, &block)
  end

  def get(path)
    1
  end

end
