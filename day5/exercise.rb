require 'net/http'
require 'open-uri'
require 'hpricot'
require 'nokogiri'


url_to_scan = 'http://satishtalim.github.com/webruby/chapter3.html'

def count_the_instances text
  num = text.scan(/\b[t|T]he\b/).count
  "#{num} instances of the or The."
end


puts "NET::HTTP solution:"
uri = URI.parse(url_to_scan)
Net::HTTP.start(uri.host, uri.port) do |http| 
	req = Net::HTTP::Get.new(uri.path)
	text = http.request(req).body
	puts count_the_instances(text)
end
puts ""

 
puts "OPEN-URI solution:"
source = open(url_to_scan)
text = source.readlines.join
puts count_the_instances(text)
puts ""
 

puts "HPRICOT solution:"
page = Hpricot(open(url_to_scan)) 
puts count_the_instances(page.inner_html)
puts ""

 
puts "NOKOGIRI solution:" 
doc = Nokogiri::HTML(open(url_to_scan))
puts count_the_instances(doc.text)
puts ""
