require 'rack'

class Shorty
  PORT = 8080
  def call(env)
    req = Rack::Request.new(env)

    message = "Hello World: #{env['REQUEST_METHOD']} #{env['PATH_INFO']}"

    [ 200, {"Content-Type" => "text/html"}, [message] ]
  end
end
