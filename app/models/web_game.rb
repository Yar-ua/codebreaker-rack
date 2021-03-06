class WebGame
  attr_accessor :game, :hints, :answers
  def initialize
    @game = Codebreaker::Game.new
    @hints = []
    @answers = []
  end
  
  def get_hint
    @hints << @game.hint
    binding.pry
  end
end