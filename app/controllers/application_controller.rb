class ApplicationController < ActionController::Base
  # Ajaxリクエストにセキュリティトークンを含ませる(OmniAuth)
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_host

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admins_users_path
    when User
      timelines_path
    end
  end

  def set_host
    Rails.application.routes.default_url_options[:host] = request.host_with_port
  end
end
