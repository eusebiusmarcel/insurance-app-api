class V1::UsersController < ApplicationController
    before_action :authenticate_user, except: :create

    def index
        users = User.all
        render json: users, status: :ok
    end

    def show
         render json: current_user, status: :ok
    end

    def create
        user = User.new(user_params)
        user.save!
        render json: { status: "Add User Success", result: user }, status: 201
    end

    def update
        current_user.update!(update_params)
        render json: { status: "Update Success", result: current_user }, status: 202
    end

    def update_password
        current_user.process_update_password(params[:old_password], params[:password].to_s)
        render json: { status: 'OK', message: 'Password telah berhasil diubah' }, status: 202
    end

    private

    def user_params
        params.permit(:name, :email, :password, :id_card_number, :gender,
                      :address, :place_of_birth, :date_of_birth)
    end

    def update_params
        params.permit(:email, :address)
    end
end
