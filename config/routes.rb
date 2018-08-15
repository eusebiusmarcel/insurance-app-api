Rails.application.routes.draw do
  namespace :v1 do
    # == User ==
    get 'users' => 'users#index'
    get 'user' => 'users#show'
    post 'user/login' => 'user_token#create'
    post 'user/create' => 'users#create'
    put 'user/update' => 'users#update'
    delete 'user/delete' => 'users#delete'

    # == Admin ==
    get 'admins' => 'admins#index'
    get 'admin' => 'admins#show'
    post 'admin/login' => 'admin_token#create'
    post 'admin/create' => 'admins#create'
    put 'admin/update' => 'admins#update'
    delete 'admin/delete' => 'admins#delete'
    get 'admin/profile/:id' => 'admins#profile'
  end
end
