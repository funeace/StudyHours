class ApplicationController < ActionController::Base
  # deviseの設定
  # Ajaxリクエストにセキュリティトークンを含ませる(OmniAuth)
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:name])
    end

    def after_sign_in_path_for(resource)
      timelines_path
    end
end
