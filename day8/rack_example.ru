#########################################
# Very basic rack application showing how to use a router based on the uri
# and how to process requests based on the HTTP method used.
#
# Usage:
# $ rackup rack_example.ru
#
# $ curl -X POST -d 'title=retire&body=I should retire in a nice island' localhost:9292/ideas
# $ curl -X POST -d 'title=ask Satish for a gift&body=Find a way to get Satish to send me a gift' localhost:9292/ideas
# $ curl localhost:9292/ideas
#
# More info: https://github.com/rack/rack/wiki/Rack-app-with-uri-and-HTTP-specific-responses
#########################################

class Idea
  attr_accessor :title, :body, :created_at

  # Memory store, gets cleared as the process is restarted
  def self.store
    @ideas ||= []
  end

  class InvalidParams < StandardError; end
  
  # create an instance based on some passed params
  def initialize(params)
    raise InvalidParams, "You need to provide at least a title" unless params['title']
    self.title = params['title']
    self.body = params['body']
    self.created_at = Time.now
  end

  # Converts an instance into a string
  def to_s
    "#{title} at #{created_at.to_s}\n#{body}"
  end
end

class IdeaAPI
  def call(env)
    request = Rack::Request.new(env)
    case request.request_method
    when 'POST'
      begin
        idea = Idea.new(request.params)
      rescue Idea::InvalidParams => error
        [400, {"Content-Type" => "text/plain"}, [error.message] ]
      else
        Idea.store << idea
        [200, {"Content-Type" => "text/plain"}, ["Idea added, currently #{Idea.store.size} ideas are in memory!"]]
      end
    when 'GET'
      [200, {"Content-Type" => "text/plain"}, [Idea.store.map{|idea, idx| idea.to_s }.join("\n\n") + "\n"]]
    else
      [404, {}, ["Did you get lost?"]]
    end
  end
end

map '/ideas' do
  run IdeaAPI.new
end
