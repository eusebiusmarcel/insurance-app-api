class V1::AdminsController < ApplicationController
    before_action :authenticate_admin, except: :create 
    before_action :set_user, only: [:profile]
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

    def profile
      if current_admin['id'].to_i == params[:id].to_i
        render json: { admin: @admin.as_json(except: ['password_digest', 'email']) }, status: 200
      else
        render json: { status: "Forbidden, You're not allowed to view this profile" }, status: 403
      end
    end

    def delete
        current_admin.destroy
        head 204
    end
    
    
    private

    def admin_params
        params.permit(:name, :email, :password, :password_confirmation, 
                      :address, :place_of_birth, :date_of_birth)
    end

    def set_user
      @admin = Admin.find(params[:id])
    end
end