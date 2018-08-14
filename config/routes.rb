Rails.application.routes.draw do
  namespace :v1 do
    # == User ==
    get 'users' => 'users#index'
    get 'user' => 'users#show'
    post 'user/login' => 'user_token#create'
    post 'user/create' => 'users#create'
    put 'user/:id/update' => 'users#update'
    delete 'user/:id/destroy' => 'users#destroy'

    # == Admin ==
    get 'admins' => 'admins#index'
    get 'admin' => 'admins#show'
    post 'admin/login' => 'admin_token#create'
    post 'admin/create' => 'admins#create'
    put 'admin/:id/update' => 'admins#update'
    delete 'admin/:id/destroy' => 'admins#destroy'
  end
end
