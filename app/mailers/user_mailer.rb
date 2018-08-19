class UserMailer < ApplicationMailer
  before_action :set_email
  def welcome
    mail to: @email_with_name, subject: "Hi #{@user.name}, welcome to Quind!"
  end

  def forgot_password
    @url = "https://quind-api.herokuapp.com/v1/user/reset/password/#{@user.reset_password_token}"
    mail to: @email_with_name, subject: "Hi #{@user.name}, this is your reset password link"
  end

  private

  def set_email
    @user = params[:user]
    @email_with_name = %("#{@user.name}" <#{@user.email}>)
  end
end
