class BaseController
  def initialize(request, session)
    @request = request
    @session = session
    @response = Rack::Response.new
  end
  
  def redirect_to(page)
    url = page == :root ? '/' : "#{page}"
    @response.redirect(url)
    @response
  end
  
  def show_page(name)
    html_body = render(name)
    set_response(html_body)
  end
  
  def not_found
    html_body = render('404_not_found')
    set_response(html_body, 404)
  end
  
  private
  
  def set_response(body, status = 200)
    @response.write(body)
    @response.status = status
    @response
  end
  
  def render(template)
    render_template('layout/layout') { render_template(template) }
  end
  
  def render_template(template, &block)
    # template = File.expand_path("../../views/#{template}.html.erb", __FILE__)
    # ERB.new(File.read(template)).result(binding &block)
    template = File.expand_path("../../views/#{template}.html.haml", __FILE__)
    Haml::Engine.new(File.read(template)).render(binding &block)
  end
end
