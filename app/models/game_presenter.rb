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
    (answer.split('') + Array.new(4 - answer.size)).map do |item|
      case item
      when Codebreaker::Game::PLUS
        collection(BTN_SUCCESS, Codebreaker::Game::PLUS)
      when Codebreaker::Game::MINUS
        collection(BTN_PRIMARY, Codebreaker::Game::MINUS)
      else
        collection(BTN_DANGER, NOPE)
      end
    end
  end

  def collection(type, value)
    { type: type, value: value }
  end
end
