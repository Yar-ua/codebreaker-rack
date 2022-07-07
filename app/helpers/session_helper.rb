class SessionHelper
  def initialize(request)
    @request = request
  end

  def save(data)
    @request.session[:web_game] = data[:web_game]
  end

  def load
    @request.session[:web_game]
  end

  def destroy
    @request.session.clear
  end

  def present?
    @request.session.key?(:web_game)
  end
end
