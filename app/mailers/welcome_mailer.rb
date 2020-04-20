class WelcomeMailer < ApplicationMailer
  def welcome_mail(user)
    @user = user
    mail(from: "StudyHours <mailsample567@gmail.com>",to: @user.email, subject: "ようこそStudyHoursへ")
  end
end
