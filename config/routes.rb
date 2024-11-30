Rails.application.routes.draw do
  get 'google_login_api/callback'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'posts#index'
  resources :posts do
    resources :pins
    collection do
      get :likes
    end
    member do
      post 'mapheader'
    end
  end
  resources :likes, only: %i[create destroy]
  resources :users
  resources :password_resets, only: %i[new create edit update]
  get  'privacy_policy', to: 'static_pages#privacy_policy'
  get  'terms_of_use', to: 'static_pages#terms_of_use'
  get  'how_to_use', to: 'static_pages#how_to_use'
  post '/google_login_api/callback', to: 'google_login_api#callback'
  get 'mypage', to: 'posts#myposts'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
