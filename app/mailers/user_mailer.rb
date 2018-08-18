class UserMailer < ApplicationMailer
  def selamat_datang(user)
    @user = user
    mail to: @user.email, subject: "Success! #{@user.name} did it."
          
  end
  def forgot_password(user)
    @user = user
    mail to: @user.email, subject: "Forgot password process"
  end
  
  
end
