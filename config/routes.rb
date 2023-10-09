Rails.application.routes.draw do

  devise_for :admin,skip: [:registrations, :passwords] , controllers: {
    sessions: "admin/sessions"
  }

  devise_for :members,skip: [:passwords] ,controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope module: :public do
    root to: 'homes#top'
    devise_scope :member do
      post "members/guest_sign_in", to: "sessions#guest_sign_in"
    end
    resources :members,  only: [:show,:edit,:update] do
      member do
        patch :withdrawal
      end
    end
    resources :posts do
      resources :comments, only: [:create,:destroy]
      resource :favorites, only: [:create,:destroy]
    end
    resources :tags, only: [:show]
  end
end
