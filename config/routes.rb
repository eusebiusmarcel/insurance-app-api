Rails.application.routes.draw do
  namespace :v1 do
    # User Collections
    get 'user' => 'users#show'
    post 'user/login' => 'authentications#authenticate_user'
    put 'user/update/password' => 'users#update_password'
    post 'user/forgot/password' => 'users#forgot_password'
    post 'user/reset/password/:token' => 'users#reset_password'

    # Admin Collections
    get 'admin' => 'admins#show'
    post 'admin/login' => 'authentications#authenticate_admin'
    put 'admin/update/password' => 'admins#update_password'
    post 'admin/forgot/password' => 'admins#forgot_password'
    post 'admin/reset/password/:token' => 'admins#reset_password'
    post 'admin/user/create' => 'admins#create_user'
    post 'admin/user/create/csv' => 'admins#create_user_by_csv'
    get 'admin/users' => 'admins#index_user'
    put 'admin/user/update/:id' => 'admins#update_user'

    # Policy Collections
    get 'admin/policies' => 'admin_policies#index'
    get 'admin/policies/user/:id' => 'admin_policies#show_policies_of_one_user'
    post 'admin/policy/create' => 'admin_policies#create'
    post 'admin/policy/create/csv' => 'admin_policies#create_by_csv'
    get 'user/policies' => 'user_policies#show_user_policies'
    put 'admin/policies/:id/document/upload' => 'admin_policies#upload_policy_document'

    # Payment Detail
    get 'admin/payment/detail/:policy_id' => 'payment_detail#detail'

    # Avatar Collections
    put 'user/avatar/upload' => 'users#upload_avatar'
    put 'admin/avatar/upload' => 'admins#upload_avatar'
    delete 'user/avatar/delete' => 'users#delete_avatar'
    delete 'admin/avatar/delete' => 'admins#delete_avatar'

    # No Login Collections
    get 'users' => 'no_logins#index_user'
    get 'policies' => 'no_logins#index_policy'
    get 'policies/user/:id' => 'no_logins#show_policies_of_one_user'
    get 'user/:id' => 'no_logins#show_user'
    get 'policy/:id' => 'no_logins#show_policy'

    # Guest Collections
    post  'guest/create' => 'guests#create_guest'
    get   'guests' => 'guests#index_guest'
    get   'guest/:id' => 'guests#show_guest'
  end
end
