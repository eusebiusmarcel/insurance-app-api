Rails.application.routes.draw do
  post 'admin_token' => 'admin_token#create'
  post 'user_token' => 'user_token#create'
  namespace :v1 do
  end
end
