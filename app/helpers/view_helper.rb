module ViewHelper
  def self.show_plus_minus(web_game)
    GamePresenter.new(web_game).results
  end
end
