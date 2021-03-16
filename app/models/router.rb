class Router
  URLS = {
    root: '/',
    rules: '/rules',
    statistics: '/stats',
    new_game: '/new_game',
    game: '/game',
    submit_answer: '/submit_answer',
    win: '/win',
    lose: '/lose',
    hint: '/hint'
  }.freeze

  def initialize(request, session)
    @request = request
    @controller = AppController.new(request, session)
  end

  def route
    return @controller.not_found unless URLS.key(@request.path)

    @controller.method(URLS.key(@request.path)).call
  end
end
