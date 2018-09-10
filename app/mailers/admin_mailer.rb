class AdminMailer < ApplicationMailer
  before_action :set_attributes
  def forgot_password
    mail to: @email_with_name, subject: "Hi #{@admin.name}, #{@admin.reset_password_token} is your reset password token"
  end

  private

  def set_attributes
    @admin = params[:admin]
    @email_with_name = %("#{@admin.name}" <#{@admin.email}>)
  end
end
