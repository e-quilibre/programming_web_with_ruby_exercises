require 'rack'

def my_method env
  [
    200,
    {"Content-Type" => "text/plain"}, 
    ["Command line argument you typed was: #{ARGV[0]}"]
  ]
end

Rack::Server.new( { :app => method(:my_method), :server => 'webrick', :Port => 8500} ).start