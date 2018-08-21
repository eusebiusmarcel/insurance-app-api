class V1::UsersController < ApplicationController
    before_action :authenticate_user, except: %i[forgot_password reset_password]
    attr_reader :current_user
    def show
        render json: { status: 'OK', user: current_user.as_json(except:
        :password_digest) }, status: :ok
    end

    def update_password
        current_user.process_update_password(params[:old_password], params[:password].to_s)
        render json: { status: 'OK', message: 'Password telah berhasil diubah' }, status: :ok
    end

    def forgot_password
        raise ExceptionHandler::AttributesNotComplete, 'Masukkan email' unless params[:email].present?
        user = User.find_by(email: params[:email])
        raise ExceptionHandler::TellingLie, Message.email_sent if user.blank?
        user.process_forgot_password
        render json: { status: 'OK', message: Message.email_sent }, status: :ok
    end

    def reset_password(token = params[:token])
        raise ExceptionHandler::AttributesNotComplete, 'Masukkan token' if token.blank?
        user = User.find_by(reset_password_token: token)
        raise ExceptionHandler::InvalidToken, Message.link_expired if user.blank?
        user.process_reset_password(params[:password].to_s)
        render json: { status: 'OK', message: Message.reset_password_succeed }, status: :ok
    end

    private

    def authenticate_user
        @current_user = AuthorizeApiRequest.new(request.headers).call_user[:user]
    end
end
