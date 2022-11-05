Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :posts
  resources :post_tags
  resources :tags
  resources :camp_tools
  #中間テーブル
  resources :relationships
  resources :favorites
  resources :comments
end
