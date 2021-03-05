module Middlewares
  class Racker
    def self.call(env)
      new(env).response.finish
    end

    def initialize(env)
      @request = Rack::Request.new(env)
      @router = Router.new(@request)
    end

    def response
      # Rack::Response.new(@router.route)
      @router.route
    end

  end
end




# def game
#   puts @request.session
#   puts @request.session[:name]
#   @response = Rack::Response.new(render('game'))
# end

# def render(template)
#   @layout = File.read(File.expand_path('./views/layouts/layout.html.erb', __dir__))
#   @template = File.read(File.expand_path("./views/#{template}.html.erb", __dir__))

#   templates = [@template, @layout]
#   templates.inject(nil) do | prev, temp |
#     _render(temp) { prev }
#   end
# end