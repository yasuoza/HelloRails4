class UserMailer < ActionMailer::Base
  self.queue = ActiveSupport::Queue.new
  default from: "from@example.com"

  def welcome_email(user)
    @user = user
    mail(to: user.email, subject: 'Welcome to My Awesome Site')
  end
end
