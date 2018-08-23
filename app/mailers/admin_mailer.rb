class AdminMailer < ApplicationMailer
  before_action :set_attributes
  def forgot_password
    @url = "https://quind-api.herokuapp.com/v1/admin/reset/password/#{@admin.reset_password_token}"
    mail to: @email_with_name, subject: "Hi #{@admin.name}, this is your reset password link"
  end

  private

  def set_attributes
    @admin = params[:admin]
    @email_with_name = %("#{@admin.name}" <#{@admin.email}>)
  end
end
