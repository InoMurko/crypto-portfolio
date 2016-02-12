require 'colorize'

DEBUG = File.exists?(File.join(File.dirname(__FILE__), '.debug'))

def log(msg)
  msg = msg.is_a?(String) ? msg : msg.inspect
  puts msg.colorize(:yellow) if DEBUG
end

log "Debug mode"

class Util

  def self.silence_warnings(&block)
    warn_level = $VERBOSE
    $VERBOSE = nil
    result = block.call
    $VERBOSE = warn_level
    result
  end

end
