Rails.application.routes.draw do
  namespace :v1 do
    # == User ==
    get 'users' => 'users#index'
    get 'user' => 'users#show'
    post 'user/login' => 'user_token#create'
    post 'user/create' => 'users#create'
    put 'user/update' => 'users#update'
    put 'user/update/password' => 'users#update_password'

    # == Admin ==
    get 'admins' => 'admins#index'
    get 'admin' => 'admins#show'
    post 'admin/login' => 'admin_token#create'
    post 'admin/create' => 'admins#create'
    put 'admin/update' => 'admins#update'
    put 'admin/update/password' => 'admins#update_password'
  end
end
