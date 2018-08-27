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
        guests = Guest.all
        render json: { status: "jos", guest: guests }, status: :ok
    end

    def filter_guest
        guest = Guest.all
        guest = guest.guests_by_product(params[:insurance_type]) if params[:insurance_type].present?
        render json: { status: "berhasil difilter", guest: guest}, status: :ok
    end

    def search_guest
        guest = Guest.all
        guest = guest.search_name(params[:name]) if params[:name].present?
        guest = guest.search_email(params[:email]) if params[:email].present?
        render json: { status: "pencarian berhasil", guest: guest}, status: :ok
    end

    private
    def guest_params
        params.require(:guest).permit(:name, :email, :phone_number, :insurance_type, :city)
    end    

    def set_guest
        @guest = Guest.find(params[:id])
    end
end    