class V1::AdminTokenController < Knock::AuthTokenController
    skip_before_action :verify_authenticity_token
    
    def create
        render json: { status: "Login succeed", jwt: auth_token.token }, status: :created
    end
end
