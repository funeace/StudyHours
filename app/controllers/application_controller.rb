class ApplicationController < ActionController::Base
  # deviseの設定
  # Ajaxリクエストにセキュリティトークンを含ませる
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:name])
    end
end
