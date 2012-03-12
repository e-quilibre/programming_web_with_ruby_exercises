my_rack_proc = lambda { |env| 
  [
    200,
    {"Content-Type" => "text/plain"}, 
    ["Command line argument you typed was: #{ARGV[0]}"]
  ]
}

puts my_rack_proc.call({})