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
        if admin.save
            render json: { status: "Add Admin Success", result: admin }, status: 201
        else
            render json: { status: "Error Add Admin", result: admin.errors }, status: 422
        end    
    end

    def update
        if current_admin
            current_admin.update(admin_params)
            if current_admin.save
                render json: { status: "Update Success", result: current_admin }, status: 202
            else
                render json: { status: "Update Problem", result: current_admin }, status: 400
            end
        end               
    end

    def delete
        current_admin.destroy
        head 204
    end
    
    
    private

    def admin_params
        params.permit(:name, :email, :password, :password_confirmation, :address, :birth_place, :birth_date)
    end

end