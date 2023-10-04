Rails.application.routes.draw do
  root to: 'public/homes#top'
  namespace :public do
    
  end
  devise_for :admin,skip: [:registrations, :passwords] , controllers: {
    sessions: "admin/sessions"
  }

  devise_for :members,controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
