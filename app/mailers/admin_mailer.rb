class AdminMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_mailer.forgot_password.subject
  #
  def forgot_password(admin)
    @admin = admin
    mail to: @admin.email, subject: "Forgot password process"
  end
end
