Rails.application.routes.draw do
  namespace :admin do
    resources :tags, only: [:index, :create, :edit, :update, :destroy]
    resources :review_tags, only: [:create, :destroy]

      resources :hospitals do
        member do
          delete :remove_main_image
          delete :remove_sub_image
        end
        resources :reviews, only: [:show, :index, :create, :edit, :update, :destroy] do
         resources :comments, only: [:index, :destroy]
        end
      end
    
      resources :users, only: [:index, :show, :edit, :update] do
        member do
          get :unsubscribe
          patch :withdraw
          patch :activate
          patch :deactivate
        end
      end
    get :searches, to: "searches#search"
    root to: "hospitals#index"
  end


  namespace :public do
    resources :tags, only: [:index, :show, :create, :destroy]
    resources :review_tags, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    resource :map, only: [:show]

      resources :hospitals, only: [:index, :show] do
        resources :reviews do
          resources :comments, only: [:create, :destroy]
        end
      end

    resources :users do
      collection do
        get :mypage
        get :publish_unpublish
        get :unsubscribe
        patch :withdraw    
        get :searches, to: "searches#search"
      end
    end
  end

  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "homes#top"
  get "about", to: "homes#about", as: "about"

end
