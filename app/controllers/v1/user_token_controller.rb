class V1::UserTokenController < Knock::AuthTokenController
    skip_before_action :verify_authenticity_token

    def create
        render json: { status: "Login berhasil", jwt: auth_token.token }, status: :created
    end
end
