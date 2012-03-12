# myapp4.rb
require 'sinatra'
get '/' do
  erb :home
end

post '/reverse' do
  erb :show
end