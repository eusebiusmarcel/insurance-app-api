Rails.application.routes.draw do
  namespace :v1 do
    # User Collections
    get 'user' => 'users#show'
    post 'user/login' => 'authentications#authenticate_user'
    put 'user/update/password' => 'users#update_password'
    post 'user/forgot/password' => 'users#forgot_password'
    post 'user/reset/password/:token' => 'users#reset_password'
    put 'user/avatar/upload' => 'users#upload_avatar'
    delete 'user/avatar/delete' => 'users#delete_avatar'

    # Admin Collections
    get 'admin' => 'admins#show'
    post 'admin/login' => 'authentications#authenticate_admin'
    put 'admin/update/password' => 'admins#update_password'
    post 'admin/forgot/password' => 'admins#forgot_password'
    post 'admin/reset/password/:token' => 'admins#reset_password'

    # User Management Collections
    post 'admin/user/import/csv' => 'users_management#create_by_csv'
    get 'admin/users' => 'users_management#index'
    put 'admin/user/update/:id' => 'users_management#update'

    # Policy Collections
    get 'admin/policies' => 'policies_management#index'
    get 'admin/policies/user/:id' => 'policies_management#show_policies_of_one_user'
    put 'admin/policies/:id/document/upload' => 'policies_management#upload_policy_document'
    post 'admin/policies/import/csv' => 'policies_management#create_by_csv'
    get 'user/policies' => 'user_policies#index'
    get 'user/policies/:id' => 'user_policies#show'

    # Payment Detail
    get 'admin/payment/detail/:policy_id' => 'payment_detail#detail'
    get 'user/payment/detail/:policy_id' => 'payment_detail#detail_by_user'
    post 'admin/payment/create' => 'payment_detail#create'
    
    # Guest Collections
    post 'guest/create' => 'guests#create'
    get 'guests' => 'guests#index'
    get 'guest/:id' => 'guests#show'
    get 'guests/csv' => 'guests#export_to_csv'
  end
end
