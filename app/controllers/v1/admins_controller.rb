class V1::AdminsController < ApplicationController
    before_action :authenticate_admin, except: %i[create forgot_password reset_password]

    def index
        admins = Admin.all
        render json: admins, status: :ok
    end

    def show
         render json: current_admin, status: :ok
    end

    def create
        admin = Admin.new(admin_params)
        admin.save!
        render json: { status: "Add Admin Success", result: admin }, status: 201
    end

    def update
        current_admin.update!(update_params)
        render json: { status: "Update Success", result: current_admin }, status: 202
    end

    def update_password
        current_admin.process_update_password(params[:old_password], params[:password].to_s)
        render json: { status: 'OK', message: 'Password telah berhasil diubah' }, status: 202
    end

    def forgot_password
        raise ExceptionHandler::AttributesNotComplete, 'Masukkan email' unless params[:email].present?
        admin = Admin.find_by(email: params[:email])
        raise ExceptionHandler::TellingLie, 'Email telah dikirim, periksa email Anda.' if admin.blank?
        admin.process_forgot_password
        render json: { status: 'OK', message: 'Email telah dikirim, periksa email Anda.' }, status: :ok
    end

    def reset_password
        token = params[:token]
        raise ExceptionHandler::AttributesNotComplete, 'Masukkan token' if token.blank?
        admin = Admin.find_by(reset_password_token: token)
        raise ExceptionHandler::InvalidToken, Message.link_expired if admin.blank?
        admin.process_reset_password(params[:password].to_s)
        render json: { status: 'OK', message: 'Password telah berubah, silahkan login kembali' }, status: :ok
    end

    private

    def admin_params
        params.permit(:name, :email, :password, :address, :place_of_birth,
                      :date_of_birth, :gender)
    end

    def update_params
        params.permit(:email, :address)
    end
end
