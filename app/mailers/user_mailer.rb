class UserMailer < ActionMailer::Base
  default from: "from@rottenmangoes.com"

  def delete_email(user)
    @user = user
    @url = 'http://rottenmangoes.com/login'

    mail(to: @user.email,
        subject: 'Your account has been deleted'
    )
  end
end
