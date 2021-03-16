class AppController < BaseController
  def initialize(request, session)
    super(request, session)
    @web_game = session.load if session.present?
  end

  def root
    show_page(:menu)
  end

  def rules
    show_page(:rules)
  end

  def statistics
    @sorted_stats = Database.sort_stats
    show_page(:statistics)
  end

  def new_game
    return redirect_to(:root) unless params?

    @web_game = WebGame.new
    init_game
    @session.save(web_game: @web_game)
    redirect_to(:game)
  end

  def submit_answer
    @web_game.run(@request[:guess])
    @session.save(web_game: @web_game)
    check_win_or_lose
  end

  def hint
    @web_game.hint
    @session.save(web_game: @web_game)
    redirect_to(:game)
  end

  def game
    show_page(:game)
  end

  def win
    @session.destroy
    show_page(:win)
  end

  def lose
    @session.destroy
    show_page(:lose)
  end

  private

  def win_game
    save_result
    redirect_to(:win)
  end

  def save_result
    stats = Stats.new(@web_game.game.user, @web_game.result)
    Database.save(stats)
  end

  def init_game
    @web_game.game.user_set(@request[:user_name])
    @web_game.game.difficulty_set(@request[:difficulty])
  end

  def check_win_or_lose
    case @web_game.status
    when Codebreaker::Game::WIN then win_game
    when Codebreaker::Game::LOSE then redirect_to(:lose)
    else
      redirect_to(:game)
    end
  end

  def params?
    (!@request[:user_name].empty? && !@request[:difficulty].empty?)
  end
end
