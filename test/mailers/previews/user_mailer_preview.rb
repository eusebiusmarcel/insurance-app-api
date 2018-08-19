class UserMailerPreview < ActionMailer::Preview
  def welcome
    UserMailer.with(user: User.last).welcome
  end

  def forgot_password
    UserMailer.with(user: User.last).forgot_password
  end
end
