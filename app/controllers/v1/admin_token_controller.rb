class V1::AdminTokenController < Knock::AuthTokenController
    skip_before_action :verify_authenticity_token
end
