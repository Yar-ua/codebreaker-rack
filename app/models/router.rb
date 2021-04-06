class Router
  def initialize(request, session)
    @request = request
    @controller = AppController.new(request, session)
  end

  def route
    path = Constants::URLS.key(@request.path)
    return @controller.not_found unless path

    @controller.method(path).call
  end
end
