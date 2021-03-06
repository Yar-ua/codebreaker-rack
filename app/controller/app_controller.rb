class AppController < BaseController
  
  def initialize(request, session)
    super(request, session)
    @web_game = session.load if session.present?
  end

  def menu
    show_page(:menu)
  end

  def rules
    show_page(:rules)
  end

  def statistics
    show_page(:statistics)
  end
  
  def game
    binding.pry
    return show_page(:game) if @session.present?
    return redirect_to(:root) unless have_params?
    
    @web_game = WebGame.new
    init_user
    init_game
    @session.save(web_game: @web_game)
    show_page(:game)
  end
  
  def hint
    @web_game.get_hint
  end
  
  def init_user
    @web_game.game.user_set(@request[:user_name])
  end
  
  def init_game
    @web_game.game.difficulty_set(@request[:difficulty])
  end
  
  def have_params?
    (!@request[:user_name].empty? && !@request[:difficulty].empty?)
  end
  
end
