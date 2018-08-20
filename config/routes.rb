Rails.application.routes.draw do
  namespace :v1 do
    # == User ==
    get 'user' => 'users#show'
    post 'user/login' => 'authentications#authenticate_user'
    put 'user/update/password' => 'users#update_password'
    post 'user/forgot/password' => 'users#forgot_password'
    post 'user/reset/password/:token' => 'users#reset_password'

    # == Admin ==
    get 'admin' => 'admins#show'
    post 'admin/login' => 'authentications#authenticate_admin'
    put 'admin/update/password' => 'admins#update_password'
    post 'admin/forgot/password' => 'admins#forgot_password'
    post 'admin/reset/password/:token' => 'admins#reset_password'
    post 'admin/user/create' => 'admins#create_user'
    get 'admin/users' => 'admins#index_user'
    put 'admin/user/update/:id' => 'admins#update_user'
  end
end
