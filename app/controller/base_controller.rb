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
    @response.write(render(name))
    @response
  end

  def not_found
    @response.write(render('404_not_found'))
    @response.status = 404
    @response
  end

  private
  
  def render(view)
    render_template('layouts/layout') { render_template(view) }
  end

  def render_template(template, &block)
    template = File.expand_path("../../views/#{template}.html.haml", __FILE__)
    Haml::Engine.new(File.read(template)).render(binding &block)
  end
end