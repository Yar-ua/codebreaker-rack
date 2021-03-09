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
    case @request.path
    when URLS[:root]          then @controller.menu
    when URLS[:rules]         then @controller.rules
    when URLS[:statistics]    then @controller.statistics
    when URLS[:new_game]      then @controller.new_game
    when URLS[:game]          then @controller.game
    when URLS[:submit_answer] then @controller.submit_answer
    when URLS[:win]           then @controller.win
    when URLS[:lose]          then @controller.lose
    when URLS[:hint]          then @controller.hint
    else 
      @controller.not_found
    end
  end
  
end
