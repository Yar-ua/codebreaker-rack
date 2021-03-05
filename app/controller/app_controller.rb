class AppController < BaseController

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
    return redirect_to(:root) unless have_params?
    init_user
    init_game
    puts @game.inspect
    show_page(:game)
  end
  
  def init_user
    @game = Codebreaker::Game.new
    @game.user_set(@request[:user_name])
  end
  
  def init_game
    @game.difficulty_set(@request[:difficulty])
  end
  
  def have_params?
    !@request[:user_name].empty? && !@request[:difficulty].empty?
  end
  
end
