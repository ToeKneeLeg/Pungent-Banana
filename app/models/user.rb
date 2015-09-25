class User < ActiveRecord::Base

  has_secure_password

  has_many :reviews

  after_destroy :delete_email_notification

  def delete_email_notification
    @user = self
    UserMailer.delete_email(@user)
  end

  def full_name
    "#{firstname} #{lastname}"
  end
  
end
