class BaseController
  def initialize(request)
    @request = request
    @response = Rack::Response.new
  end
  
  def show_page(name)
    @response.write(render(name))
    @response
  end
  
  def render(template)
    path = File.expand_path("../../views/#{template}.html.erb", __FILE__)
    page = ERB.new(File.read(path)).result(binding)
  end

end
