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
    post "members/guest_sign_in", to: "members/sessions#guest_sign_in"
    resources :members,  only: [:show,:edit,:update] do
      member do
        patch :withdrawal
      end
    end
    resources :posts, except: [:new] do
      resources :post_comments, only: [:create,:destroy]
      resource :favorites, only: [:create,:destroy]
    end
  end
end
