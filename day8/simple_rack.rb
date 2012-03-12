#simple_rack.rb
class SimpleRack
  def call(env)
    [200, {"Content-Type" => "text/html"}, ["Command line argument you typed was: #{ARGV[0]}"]]
  end
end