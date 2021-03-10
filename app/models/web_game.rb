class WebGame
  attr_reader :game, :hints, :guesses, :answers, :status, :result
  
  def initialize
    @game = Codebreaker::Game.new
    @hints = []
    @guesses = []
    @answers = []
    @status = :in_process
  end
  
  def get_hint
    hint = @game.hint[:message]
    @hints << hint unless hint == Codebreaker::Game::NO_HINT
  end
  
  def run(guess)
    answer = @game.run(guess)
    check_response(guess, answer)
  end
  
  private
  
  def check_response(guess, answer)
    case answer[:status]
    when Codebreaker::Game::WIN then win(answer)
    when Codebreaker::Game::LOSE then lose
    else
      @guesses << guess
      @answers << answer[:message]
    end
  end
  
  def win(answer)
    @result = answer[:message]
    @status = Codebreaker::Game::WIN
  end
  
  def lose
    @status = Codebreaker::Game::LOSE
  end
end
