module Middleware
  class AuthMiddleware
    attr_reader :status

    def initialize(app, status = 302)
      @app = app
      @status = status
    end

    def call(env)
      @request = Rack::Request.new(env)
      return [@status, { 'Location' => Constants::URLS[:root] }, ['']] if !authenticated? && auth_location?

      @app.call(env)
    end

    private

    def authenticated?
      @request.session.key?(:web_game)
    end

    def auth_location?
      Constants::AUTH_URLS.include?(@request.path)
    end
  end
end
