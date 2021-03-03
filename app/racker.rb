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
      Rack::Response.new(@router.route)
    end

    # def response
    #   case @request.path
    #   when '/' then Rack::Response.new(render('menu.html.erb'))
    #   when '/rules' then Rack::Response.new(render('rules.html.erb'))
    #   when '/stats' then Rack::Response.new(render('statistics.html.erb'))
    #   when '/game' then Rack::Response.new(render('game.html.erb'))
    #   when '/win' then Rack::Response.new(render('win.html.erb'))
    #   when '/lose' then Rack::Response.new(render('lose.html.erb'))
    #   else Rack::Response.new('Not Found', 404)
    #   end
    # end

    # def render(template)
    #   path = File.expand_path("../views/#{template}", __FILE__)
    #   ERB.new(File.read(path)).result(binding)
    # end

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