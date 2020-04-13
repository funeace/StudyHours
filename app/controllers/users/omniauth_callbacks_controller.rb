class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # twitterのOmniAuth
  def twitter
    flash[:notice] = "ログインに成功しました"
    callback(:twitter)
  end

  # googleのOmniAuth
  def google
    # binding.pry
    flash[:notice] = "ログインに成功しました"
    callback(:google)
  end


private
  # googleもtwitterも、プロバイダー以外は同様の処理を行うためメソッドにまとめる
  def callback(provider)
    user = User.from_omniauth(request.env["omniauth.auth"])
    # binding.pry
    if user.persisted?
      sign_in_and_redirect user,event: :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end    
  end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
