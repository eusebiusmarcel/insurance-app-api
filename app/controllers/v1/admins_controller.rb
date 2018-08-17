class V1::AdminsController < ApplicationController
    before_action :authenticate_admin, except: %i[forgot_password reset_password]
    def show
        render json: { status: 'OK', admin: current_admin }, status: :ok
    end

    def update_password
        current_admin.process_update_password(params[:old_password], params[:password].to_s)
        render json: { status: 'OK', message: 'Password telah berhasil diubah' }, status: :ok
    end

    def forgot_password
        raise ExceptionHandler::AttributesNotComplete, 'Masukkan email' unless params[:email].present?
        admin = Admin.find_by(email: params[:email])
        raise ExceptionHandler::TellingLie, 'Email telah dikirim, periksa email Anda.' if admin.blank?
        admin.process_forgot_password
        render json: { status: 'OK', message: 'Email telah dikirim, periksa email Anda.' }, status: :ok
    end

    def reset_password(token = params[:token])
        raise ExceptionHandler::AttributesNotComplete, 'Masukkan token' if token.blank?
        admin = Admin.find_by(reset_password_token: token)
        raise ExceptionHandler::InvalidToken, Message.link_expired if admin.blank?
        admin.process_reset_password(params[:password].to_s)
        render json: { status: 'OK', message: 'Password telah berubah, silahkan login kembali' }, status: :ok
    end

    def index_user
        users = User.all
        render json: { users: users }, status: :ok
    end

    def create_user
        user = User.new(user_params)
        user.save!
        render json: { status: "User berhasil dibuat", result: user }, status: :created
    end

    def update_user
        user = User.find(params[:id])
        user.update!(update_user_params)
        render json: { status: "User berhasil diupdate", result: user }, status: :created
    end

    private

    def user_params
        params.permit(:name, :email, :password, :id_card_number, :gender,
                      :address, :phone_number, :place_of_birth, :date_of_birth)
    end

    def update_user_params
        params.permit(:email, :address, :phone_number)
    end
end
