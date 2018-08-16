class V1::AdminsController < ApplicationController
    before_action :authenticate_admin, except: :create

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

    private

    def admin_params
        params.permit(:name, :email, :password, :address, :place_of_birth,
                      :date_of_birth, :gender)
    end

    def update_params
        params.permit(:email, :address)
    end
end
