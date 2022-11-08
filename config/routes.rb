Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do
    post 'users/guest_sign_in' => 'users/sessions#guest_sign_in'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "posts#index"
  resources :posts
  resources :post_tags
  resources :tags
  resources :camp_tools
  #中間テーブル
  resources :relationships
  resources :favorites
  resources :comments
end
