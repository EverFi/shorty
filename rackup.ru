require_relative 'lib/shorty'

Rack::Handler::WEBrick.run Shorty.new, port: Shorty::PORT
