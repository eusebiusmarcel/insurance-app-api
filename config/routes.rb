Rails.application.routes.draw do
  mount ForestLiana::Engine => '/forest'
  namespace :v1 do
    # User Collection
    get 'user' => 'users#show'
    post 'user/login' => 'authentications#authenticate_user'
    put 'user/update/password' => 'users#update_password'
    post 'user/forgot/password' => 'users#forgot_password'
    post 'user/reset/password/:token' => 'users#reset_password'
    put 'user/avatar/upload' => 'users#upload_avatar'
    delete 'user/avatar/delete' => 'users#delete_avatar'

    # User Policy Collection
    get 'user/policies' => 'user_policies#index'
    get 'user/policies/:id' => 'user_policies#show'

    # User Claim Collection
    get 'user/claims' => 'user_claims#index'
    get 'user/claims/:id' => 'user_claims#show'

    # User Payment Collection
    get 'user/payments' => 'user_payments#index'
    get 'user/payments/:id' => 'user_payments#show'

    # Admin Collection
    get 'admin' => 'admins#show'
    post 'admin/login' => 'authentications#authenticate_admin'
    put 'admin/update/password' => 'admins#update_password'
    post 'admin/forgot/password' => 'admins#forgot_password'
    post 'admin/reset/password/:token' => 'admins#reset_password'

    # Users Management Collection
    post 'admin/user/import/csv' => 'users_management#create_by_csv'
    get 'admin/users' => 'users_management#index'
    put 'admin/user/update/:id' => 'users_management#update'

    # Policies Management Collection
    get 'admin/policies' => 'policies_management#index'
    put 'admin/policies/:id/document/upload' => 'policies_management#upload_policy_document'
    post 'admin/policies/import/csv' => 'policies_management#create_by_csv'

    # Claims Management Collection
    get 'admin/claim' => 'claims_management#index'
    post 'admin/claim/policy/:id/create' => 'claims_management#create'
    put 'admin/claim/:id/status' => 'claims_management#change_status'

    # Payments Management Collection
    get 'admin/payment' => 'payments_management#index'
    post 'admin/payment/policy/:id/create' => 'payments_management#create'

    # Payment Detail Collection
    get 'admin/payment/detail/:policy_id' => 'payments#detail'
    get 'user/payment/detail/:policy_id' => 'payments#detail_by_user'
    post 'admin/payment/create' => 'payments#create'
    
    # Guest Collection
    post 'guest/create' => 'guests#create'
    get 'guests' => 'guests#index'
    get 'guests/csv' => 'guests#export_to_csv'
  end
end
