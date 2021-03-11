module Middleware
  class AuthMiddleware
    AUTH_URL = ['/game', '/submit_answer', '/hint', '/win', '/lose'].freeze
    FREE_URL = ['/', '/rules', '/stats', '/new_game'].freeze
    
    private_constant :AUTH_URL, :FREE_URL

    attr_reader :status

    def initialize(app, status = 302)
      @app = app
      @status = status
    end

    def call(env)
      @request = Rack::Request.new(env)
      return [@status, { 'Location' => Router::URLS[:root] }, ['']] if !authenticated? && auth_location?

      @app.call(env)
    end

    private

    def authenticated?
      @request.session.key?(:web_game)
    end

    def auth_location?
      AUTH_URL.include?(@request.get_header('PATH_INFO'))
    end

    def free_location?
      FREE_URL.include?(@request.get_header('PATH_INFO'))
    end
  end
end
