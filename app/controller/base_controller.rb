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
    prepeare_response(name)
    @response
  end

  def not_found
    prepeare_response('404_not_found', 404)
    @response
  end

  private
  
  def prepeare_response(view, code = 200)
    @response.write(render(view))
    @response.status = code
  end
  
  def render(view)
    render_template('layouts/layout') { render_template(view) }
  end

  def render_template(template, &block)
    template = File.expand_path("../../views/#{template}.html.haml", __FILE__)
    Haml::Engine.new(File.read(template)).render(binding &block)
  end
end