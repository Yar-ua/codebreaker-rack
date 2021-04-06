class GamePresenter
  def initialize(web_game)
    @answers = web_game.answers
    @guesses = web_game.guesses
  end

  def results
    @results = []
    @answers.map.with_index do |answer, index|
      @results << { guess: @guesses[index], buttons: collect_buttons(answer) }
    end
    @results
  end

  private

  def collect_buttons(answer)
    (answer.split('') + Array.new(Constants::CODE_LENGTH - answer.size)).map do |item|
      case item
      when Codebreaker::Game::PLUS
        collection(Constants::BTN_SUCCESS, Codebreaker::Game::PLUS)
      when Codebreaker::Game::MINUS
        collection(Constants::BTN_PRIMARY, Codebreaker::Game::MINUS)
      else
        collection(Constants::BTN_DANGER, Constants::NOPE)
      end
    end
  end

  def collection(type, value)
    { type: type, value: value }
  end
end
