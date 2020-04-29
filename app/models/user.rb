class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[twitter google]

  after_create :send_welcome_mail

  # 論理削除
  acts_as_paranoid

  # ノートのアソシエーション
  has_many :notes, dependent: :destroy
  has_many :note_favorites, dependent: :destroy
  has_many :note_comments, dependent: :destroy

  # 学習記録のアソシエーション
  has_many :study_logs, dependent: :destroy
  has_many :study_log_favorites, dependent: :destroy
  has_many :study_log_comments, dependent: :destroy

  # フォロー・フォロワーのアソシエーション
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user
  has_many :entries, dependent: :destroy
  has_many :rooms, through: :entries
  has_many :chats, dependent: :destroy

  # 通知機能のアソシエーション
  has_many :notifications, dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visit_id', dependent: :destroy

  # refileを使うための設定
  attachment :profile_image

  # ユーザ名が空白じゃない
  validates :name, presence: true
  # 目標時間(時間)が0~23時間
  validates :goal_hour, length: { in: 0..23 }, presence: true
  # 目標時間(分)が0~59分
  validates :goal_minute, length: { in: 0..59 }, presence: true
  # 自己紹介文が200文字以内
  validates :introduction, length: { maximum: 200 }

  # 対象ユーザがフォロー中か確認するメソッド
  def following?(user)
    followings.include?(user)
  end

  # 対象ユーザをフォローするメソッド
  def follow(user)
    return unless following?(user) == false

    relationships.create(follow_id: user.id)
  end

  # 対象ユーザのフォローを解除するメソッド
  def unfollow(user)
    relationships.find_by(follow_id: user.id).destroy
  end

  # 通算の学習時間を表示するメソッド
  def total_study_logs
    hour = 0
    minute = 0
    study_logs.each do |total_study_log|
      hour += total_study_log.hour
      minute += total_study_log.minute
    end
    calchour = minute / 60
    hour += calchour
    minute = minute % 60
    return [hour, minute]
  end

  # １週間の学習時間を表示するメソッド
  def weekly_study_logs
    hour = 0
    minute = 0
    # 月曜日~日曜日で集計を行う(rubyの標準)
    study_logs.where(working_date: (Date.today.beginning_of_week)..(Date.today.end_of_week)).find_each do |weekly_study_log|
      hour += weekly_study_log.hour
      minute += weekly_study_log.minute
    end
    calchour = minute / 60
    hour += calchour
    minute = minute % 60
    return [hour, minute]
  end

  # 今週の目標に対する進捗率を表示するメソッド(分単位で計算・return値は%現在何%か)
  def weekly_progress
    study_hours = (weekly_study_logs[0] * 60 + weekly_study_logs[1]).to_f
    goal_hours = (goal_hour * 60 + goal_minute).to_f
    return 100 if goal_hours.zero?

    return ((study_hours / goal_hours).floor(1) * 100).to_i
  end

  # 投稿情報を集計して配列で返すメソッド(最終的なgonの処理はコントローラで行う)
  def chart_create
    # ユーザの投稿内容に紐づいたtagを取得する処理
    study_data = []
    chart_data = []
    study_logs.each do |study_log|
      study_data.push(study_log.tags_on(:tags))
    end
    # ユーザが投稿したタグの情報を全て取得
    study_data.each do |sdata|
      sdata.length.times do |i|
        chart_data.push([sdata[i].name, sdata[i].color_code])
      end
    end
    return chart_data.group_by(&:itself).map { |x, z| [x.flatten, z.size].flatten }
  end

  # ユーザ登録後にメールを送信する処理
  def send_welcome_mail
    WelcomeMailer.welcome_mail(self).deliver
  end

  protected

  # twitterの場合メールアドレスが持ってこれないため、ダミーデータが登録されている
  def self.from_omniauth(auth)
    user = if auth.provider == :twitter
             User.find_by(email: User.dummy_email(auth))
           else
             User.find_by(email: auth.info.email)
           end
    # if auth.provider == :twitter
    #   user = User.find_by(email: User.dummy_email(auth))
    # else
    #   user = User.find_by(email: auth.info.email)
    # end

    unless user
      case auth.provider
      when :twitter
        user = User.create(provider: auth.provider,
                           uid: auth.uid,
                           email: User.dummy_email(auth),
                           name: auth.info.name,
                           password: Devise.friendly_token[0, 20])
      when :google
        user = User.create(provider: auth.provider,
                           uid: auth.uid,
                           email: auth.info.email,
                           name: auth.info.name,
                           password: Devise.friendly_token[0, 20])
      end
    end
    user
  end

  # Twitterのアカウントはemailがnilとなってしまうため、ダミーを用意する
  def self.dummy_email(auth)
    return "#{auth.uid}-#{auth.provider}@dummy.co.jp"
  end
end
