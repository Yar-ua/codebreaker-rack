class WebGame
  attr_reader :game, :hints, :guesses, :answers, :win, :lose
  def initialize
    @game = Codebreaker::Game.new
    @hints = []
    @guesses = []
    @answers = []
    @win = false
    @lose = false
  end
  
  def get_hint
    hint = @game.hint[:message]
    @hints << hint unless hint == Codebreaker::Game::NO_HINT
  end
  
  def run(guess)
    @guesses << guess
    answer = @game.run(guess)
    case answer[:status]
    when Codebreaker::Game::WIN then @win = true
    when Codebreaker::Game::LOSE then @lose = true
    else 
      @answers << answer[:message]
    end
  end
  
end
