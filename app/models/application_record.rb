class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # いいねの通知を作成する処理
  def create_notification_favorite!(current_user,action)
    case action
    when "study_log_favorite"
      #すでにいいねが存在しているか判定
      # binding.pry
      already_favorite = Notification.where("user_id = ? and visit_id = ? and study_log_id = ? and action = ?",
        current_user.id, self.user_id, self.id, action)
      if already_favorite.blank?
        notification = current_user.notifications.new(
          visit_id: self.user_id,
          study_log_id: self.id,
          action: action
        )
        # いいねした投稿が自分のものであった場合は、通知済みにする
        if notification.user_id == notification.visit_id
          notification.checked = true
        end
        notification.save
      end
    when "note_favorite"
      #すでにいいねが存在しているか判定
      already_favorite = Notification.where("user_id = ? and visit_id = ? and note_id = ? and action = ?",
        current_user.id, self.user_id, self.id, action)
      if already_favorite.blank?
        notification = current_user.notifications.new(
          visit_id: self.user_id,
          note_id: self.id,
          action: action
        )
        # いいねした投稿が自分のものであった場合は、通知済みにする
        if notification.user_id == notification.visit_id
          notification.checked = true
        end
        notification.save
      end
    end
  end

  # コメントの通知を作成する処理
  def create_notification_comment!(current_user,comment_id,action)
    # binding.pry

    # 既にコメントが存在する場合は、自分以外のコメントしたユーザ全員に通知を送る
    case action
    when "study_log_comment"
      comment_users = StudyLogComment.select(:user_id).where(study_log_id: self.id).where.not(user_id: current_user.id).distinct
    when "note_comment"
      comment_users = NoteComment.select(:user_id).where(note_id: self.id).where.not(user_id: current_user.id).distinct
    end
    comment_users.each do |comment_user|
      save_notification_comment!(current_user,comment_id, comment_user.user_id,action)
    end
    # 投稿者に通知を送る
    save_notification_comment!(current_user,comment_id, self.user_id, action)
  end

  # 実際に通知を作成する処理
  def save_notification_comment!(current_user,comment_id, visit_id, action)
    case action
    when "study_log_comment"
      notification = current_user.notifications.new(
        study_log_id: self.id,
        visit_id: visit_id,
        study_log_comment_id: comment_id,
        action: action
      )
    when "note_comment"
      notification = current_user.notifications.new(
        note_id: self.id,
        visit_id: visit_id,
        note_comment_id: comment_id,
        action: action
      )
    end
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.user_id == notification.visit_id
      notification.checked = true
    end
      notification.save
  end

  # フォローの通知を作成する処理
  def create_notification_follow!(current_user,action)
    follow = Notification.where("user_id = ? and visit_id = ? and action = ?",current_user.id, self.id, action)
    if follow.blank?
      notification = current_user.notifications.new(
        visit_id: id,
        action: action
      )
      notification.save
    end
  end
end
