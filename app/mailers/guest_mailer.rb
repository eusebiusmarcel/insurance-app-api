class GuestMailer < ApplicationMailer
  before_action :set_attributes
  def welcome
    mail to: @email_with_name, subject: "Hi #{@guest.name}, thank you for your interest to join Quind!"
  end

  def set_attributes
    @guest = params[:guest]
    @email_with_name = %("#{@guest.name}" <#{@guest.email}>)
  end
end
