class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # twitterのOmniAuth
  def twitter
    if invalid_user?(:twitter)
    # 既に退会済みユーザか判定
      redirect_to root_path
      flash[:danger] = "無効なユーザです"
    else
      callback(:twitter)
      flash[:success] = "ログインに成功しました"
    end
  end

  # googleのOmniAuth
  def google
    # binding.pry
    if invalid_user?(:google)
      redirect_to root_path
      flash[:danger] = "無効なユーザです"
    else
      callback(:google)
      flash[:success] = "ログインに成功しました"
    end
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

  # 既に退会済みのユーザか判定するためのメソッド
  def invalid_user?(provider)
    if provider == :twitter
      invalid = User.only_deleted.find_by(email: User.dummy_email(request.env["omniauth.auth"])).nil?
    elsif provider == :google
      invalid = User.only_deleted.find_by(email: request.env["omniauth.auth"]["info"]["email"]).nil?
    end
    # invalidを反転させることでvalid = trueならば正を作る
    return !invalid
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
