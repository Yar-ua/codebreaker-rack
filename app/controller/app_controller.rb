class AppController < BaseController

  def menu
    show_page(:menu)
  end

  def rules
    show_page(:rules)
  end

  def statistics
    show_page (:statistics)
  end
  
end
