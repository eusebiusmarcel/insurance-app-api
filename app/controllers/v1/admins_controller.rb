class V1::AdminsController < ApplicationController
    before_action :authenticate_admin, except: %i[forgot_password reset_password]
    def show
        render json: { status: 'OK', admin: current_admin.as_json(except:
        :password_digest) }, status: :ok
    end

    def upload_avatar
        current_admin.remove_avatar! unless current_admin.avatar.blank?
        current_admin.update!(params.permit(:avatar))
        render json: { status: 'Avatar berhasil diupload, silahkan lihat profile anda' }, 
               status: :ok
    end

    def delete_avatar
        current_admin.remove_avatar!
        current_admin.save!
        render json: { status: 'Avatar berhasil dihapus' }, status: :ok
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

    def index_user
        users = User.order(:id).page(params[:page])
        render json: { users: users.as_json(except:
        %i[password_digest reset_password_token reset_password_token_sent_at]) },
               status: :ok
    end

    def create_user
        user = User.new(user_params)
        user.password = user.generate_token
        user.save!
        UserMailer.with(user: user).welcome.deliver
        render json: { status: "User berhasil dibuat", result: user.as_json(except:
        %i[password_digest reset_password_token reset_password_token_sent_at]) },
               status: :created
    end

    def create_user_by_csv
        User.import!(params[:file])
        render json: { created_users: User.created_users.as_json(except: %i[password_digest reset_password_token reset_password_token_sent_at]),
            failed_to_create_users: User.failed_to_create_users.as_json(except: %i[password_digest reset_password_token reset_password_token_sent_at])}, status: :ok
    end

    def update_user
        user = User.find(params[:id])
        @old_email = user.email
        user.update!(update_user_params)
        send_new_password_to_new_email(user) unless params[:email].blank?
        render json: { status: "User berhasil diupdate", result: user.as_json(except:
            %i[password_digest reset_password_token reset_password_token_sent_at]) },
               status: :ok
    end

    private

    def user_params
        params.permit(:name, :email, :id_card_number, :gender, :city,
                      :address, :phone_number, :place_of_birth, :date_of_birth)
    end

    def update_user_params
        params.permit(:email, :address, :phone_number)
    end

    def send_new_password_to_new_email(user)
        return if user.email == @old_email
        user.password = user.generate_token
        user.save!
        UserMailer.with(user: user).change_email.deliver
    end
    
end
