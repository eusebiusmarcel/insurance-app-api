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
        admin = Admin.find_by(email: params[:email].downcase)
        raise ExceptionHandler::TellingLie, Message.email_sent if admin.blank?
        admin.process_forgot_password
        render json: { status: 'OK', message: Message.email_sent }, status: :ok
    end

    def reset_password(token = params[:token])
        raise ExceptionHandler::AttributesNotComplete, 'Masukkan token' if token.blank?
        admin = Admin.find_by(reset_password_token: token)
        raise ExceptionHandler::InvalidToken, Message.link_expired if admin.blank?
        admin.process_reset_password(params[:password].to_s)
        render json: { status: 'OK', message: Message.reset_password_succeed }, status: :ok
    end
end
