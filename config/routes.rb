Rails.application.routes.draw do
  namespace :admin do
    resources :tags, only: [:index, :show, :create, :edit, :update, :destroy]
    resources :review_tags, only: [:create, :destroy]
    # タグ機能用
    resources :reviews, only: [:index]

      resources :hospitals do
        member do
          delete :remove_main_image
          delete :remove_sub_image
          delete :remove_tag
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
    resources :reviews, only: [:index]

      resources :hospitals, only: [:index, :show] do
        resources :reviews do
          member do
            delete :remove_tag
          end
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

  devise_for :admins,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }, path: 'admin'
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "homes#top"
  get "about", to: "homes#about", as: "about"

  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

end
