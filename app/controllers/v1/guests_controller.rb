class V1::GuestsController < ApplicationController
    before_action :set_guest, only: [:show_guest, :update_guest, :delete_guest]
    def create_guest
        guest = Guest.new(guest_params)
        guest.save!
        render json: { status: "Guest berhasil mendaftar"}, status: :ok
    end

    def show_guest
        render json:{ guest: @guest }, status: :ok
    end

    def index_guest
        guests = Guest.order(:id)
        guests = guests.guests_by_product(params[:insurance_type]) if params[:insurance_type].present?
        guests = guests.search_name(params[:name]) if params[:name].present?
        guests = guests.search_email(params[:email]) if params[:email].present?
        guests_per_page = guests.page(params[:page])
        render json: { status: "OK", total_guests: guests.count, guests: guests_per_page }, status: :ok
    end

    def export_to_csv
        @guests = Guest.all
        send_data @guests.to_csv, filename: "Data_QUIND_GUEST #{Date.today}.csv"
    end

    private

    def guest_params
        params.require(:guest).permit(:name, :email, :phone_number, :insurance_type, :city)
    end

    def set_guest
        @guest = Guest.find(params[:id])
    end
end
