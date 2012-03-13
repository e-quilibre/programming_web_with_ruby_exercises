# rack_middleware.rb
module RackMiddleware
  class Hello
    def initialize(app)
      @app = app
    end

    def call(env)
      if env['PATH_INFO'] == '/newroute'
        [404,  {"Content-Type" => "text/plain"}, ["Not OK!"]]
      else
        # forward the request
        @app.call(env)
      end
    end
  end
end