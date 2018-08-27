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
        guests = Guest.all.order(:id)
        render json: { status: "OK", guest: guests }, status: :ok
    end

    def filter_guest
        guest = Guest.all.order(:id)
        guest = guest.guests_by_product(params[:insurance_type]) if params[:insurance_type].present?
        render json: { status: "Guest berhasil difilter", guest: guest}, status: :ok
    end

    def search_guest
        guest = Guest.all.order(:id)
        guest = guest.search_name(params[:name]) if params[:name].present?
        guest = guest.search_email(params[:email]) if params[:email].present?
        render json: { status: "Pencarian berhasil", guest: guest}, status: :ok
    end

    private

    def guest_params
        params.require(:guest).permit(:name, :email, :phone_number, :insurance_type, :city)
    end

    def set_guest
        @guest = Guest.find(params[:id])
    end
end
