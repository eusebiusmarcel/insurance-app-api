class V1::GuestsController < ApplicationController
  before_action :authenticate_admin, except: :create

  def create
    guest = Guest.new(guest_params)
    user = User.find_by(email: params[:email])
    raise ExceptionHandler::AlreadyRegisteredAsUser, Message.already_registed_as_user unless user.blank?
    guest.save!
    GuestMailer.with(guest: guest).welcome.deliver
    render json: { status: "Guest berhasil mendaftar"}, status: :ok
  end

  def index
    guests = Guest.all.order(:id)
    guests = guests.guests_by_product(params[:insurance_type]) if params[:insurance_type].present?
    guests = guests.search_name(params[:name]) if params[:name].present?
    guests = guests.search_email(params[:email]) if params[:email].present?
    guests_per_page = guests.paginate(page: params[:page])
    render json: { status: "OK", total_guests: guests.count, guests: guests_per_page }, status: :ok
  end

  def export_to_csv
    guests = Guest.all
    send_data guests.to_csv, filename: "Data_QUIND_GUEST #{Date.today}.csv"
  end

  private

  def guest_params
    params.require(:guest).permit(:name, :email, :phone_number, :insurance_type, :city)
  end
end
