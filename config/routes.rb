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
    get 'admin/policies' => 'policies#index'
    post 'admin/policy/create' => 'policies#create'
    post 'admin/policy/create/csv' => 'policies#create_by_csv'
    get 'user/policies' => 'policies#show_user_policies'

    # Avatar Collections
    put 'user/avatar/upload' => 'users#upload_avatar'
    put 'admin/avatar/upload' => 'admins#upload_avatar'
  end
end
