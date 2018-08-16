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
        if user.save
            render json: { status: "Add User Success", result: user }, status: 201
        else
            render json: { status: "Error Add User", result: user.errors }, status: 422
        end
    end

    def update
        current_user.update(user_params)
        if current_user.save
            render json: { status: "Update Success", result: current_user }, status: 202
        else
            render json: { status: "Update Error", result: current_user.errors }, status: 422
        end
    end

    private

    def user_params
        params.permit(:name, :email, :password, :password_confirmation,
                      :address, :place_of_birth, :date_of_birth)
    end
end
