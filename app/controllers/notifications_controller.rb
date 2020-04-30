class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.passive_notifications
                                 .where.not(user_id: current_user.id)
    # 自身の投稿については既にchecked:trueのはず
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
    # binding.pry
  end
end
