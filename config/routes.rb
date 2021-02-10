Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace 'api' do
    namespace 'v1' do
      resources :users, only: [:create]
      get "/users", to: "users#show" 
      post "/login", to: "users#login"
      get "/auto_login", to: "users#auto_login"
      resources :advertisements 
    end
  end
end
