class ApplicationController < ActionController::API
  # before_action :authenticate

  def logged_in?
    !!current_user
  end

  def not_logged_in?
    !logged_in?
  end

  def current_user
    if auth_present?
      user = User.find(auth["user"])
      if user
        @current_user ||= user
      end
    end
  end

  def authenticate
    if not_logged_in?
      render json: { error: 'unauthorized' }, status: 401
    end
  end

  private

  def token
    request.env["HTTP_AUTHORIZATION"].scan(/Bearer(.*)$/).flatten.last
  end

  def auth
    Auth.decode(token)
  end

  def auth_present?
    !!request.env.fetch("HTTP_AUTHORIZATION", "").scan(/Bearer/).flatten.first
  end
end
