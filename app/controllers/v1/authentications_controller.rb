class V1::AuthenticationsController < ApplicationController
  def authenticate_user
    auth_token =
      Authenticate.new(auth_params[:email], auth_params[:password]).call_user
    render json: { message: 'Login berhasil!', jwt: auth_token }
  end

  def authenticate_admin
    auth_token =
      Authenticate.new(auth_params[:email], auth_params[:password]).call_admin
    render json: { message: 'Login berhasil!', jwt: auth_token }
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
