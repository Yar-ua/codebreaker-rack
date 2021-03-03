class AppController
  def initialize(request)
    @request = request
    @response = Rack::Response.new    
  end

  def menu
    show_page(:menu)
  end

  def rules
    show_page(:rules)
  end

  def statistics
    show_page (:statistics)
  end

  def show_page(template)
    path = File.expand_path("../../views/#{template}.html.erb", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end

end
