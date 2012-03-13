require './rack_middleware'
use RackMiddleware::Hello # this comes in between
run Proc.new{|env|  [200, {"Content-Type" => "text/plain"}, ['OK!']] }