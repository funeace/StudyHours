module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    # ActionCableにはcurrent_userが存在しないため、作成する
    def connect
      # ユーザのidを取得
      session_id = cookies.encrypted[Rails.application.config.session_options[:key]]["warden.user.user.key"][0][0]
      self.current_user = User.find(session_id)
    end
  end
end
