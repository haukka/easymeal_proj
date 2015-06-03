# -*- encoding : utf-8 -*-
class UserMail < ActionMailer::Base
  default from: "from@example.com"

  def welcome_user(user)
    @user = user
    mail(to:@user.mail, subject: 'welcome to easymeal')
  end
end
