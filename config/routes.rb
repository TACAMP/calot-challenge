Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do
    post 'users/guest_sign_in' => 'users/sessions#guest_sign_in'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "posts#index"

  resources :users , only:[:show,:edit,:update] do
    resource :relationships , only:[:create,:destroy] do
    get 'followings' => 'relationships#followings' , as: 'followings'
    get 'followers' => 'relationships#followers' , as: 'followers'
    end
    member do
      get :favorites
    end
  end
  resources :posts do
    resource :favorites , only:[:create,:destroy]
    resources :comments , only:[:create,:destroy]
  end
  resources :post_tags
  resources :tags
  resources :camp_tools
  #中間テーブル
  resources :relationships
  get 'search' => 'searches#search'
end
