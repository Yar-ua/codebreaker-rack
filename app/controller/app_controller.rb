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
    return show_page(:game) if @session.present?
    return redirect_to(:root) unless have_params?

    new_game
  end
  
  def new_game
    @web_game = WebGame.new
    init_user
    init_game
    @session.save(web_game: @web_game)
    show_page(:game)
  end
  
  def hint
    @web_game.get_hint
    @session.save(web_game: @web_game)
    show_page(:game)
  end
  
  def submit_answer
    @web_game.run(guess_params)
    @session.save(web_game: @web_game)
    check_win_or_lose
    show_page(:game)
  end
  
  def win
    show_page(:win)
  end
  
  def lose
    show_page(:lose)
  end
  
  private
  
  def init_user
    @web_game.game.user_set(@request[:user_name])
  end
  
  def init_game
    @web_game.game.difficulty_set(@request[:difficulty])
  end
  
  def check_win_or_lose
    return redirect_to(:win) if @web_game.win == true
    return redirect_to(:lose) if @web_game.lose == true
  end
  
  def have_params?
    (!@request[:user_name].empty? && !@request[:difficulty].empty?)
  end
  
  def guess_params
    @request[:guess]
  end
  
end
