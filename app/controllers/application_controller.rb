class ApplicationController < ActionController::API
    include ExceptionHandler

    attr_reader :current_admin, :current_user

    def authenticate_admin
        @current_admin = AuthorizeApiRequest.new(request.headers).call_admin[:admin]
    end

    def authenticate_user
        @current_user = AuthorizeApiRequest.new(request.headers).call_user[:user]
    end
end
