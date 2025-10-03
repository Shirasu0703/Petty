Rails.application.routes.draw do
  namespace :admin do
    get 'tags/index'
    get 'tags/create'
    get 'tags/edit'
    get 'tags/update'
    get 'tags/destroy'
  end
  namespace :admin do
    get 'review_tags/create'
    get 'review_tags/destroy'
  end
  namespace :admin do
    get 'hospitals/new'
    get 'hospitals/index'
    get 'hospitals/show'
    get 'hospitals/create'
    get 'hospitals/edit'
    get 'hospitals/update'
    get 'hospitals/destroy'
  end
  namespace :admin do
    get 'reviews/index'
    get 'reviews/create'
    get 'reviews/edit'
    get 'reviews/update'
    get 'reviews/destroy'
  end
  namespace :admin do
    get 'comments/index'
    get 'comments/destroy'
  end
  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
    get 'users/update'
  end
  namespace :public do
    get 'tags/index'
    get 'tags/show'
    get 'tags/create'
    get 'tags/destroy'
  end
  namespace :public do
    get 'review_tags/create'
    get 'review_tags/destroy'
  end
  namespace :public do
    get 'favorites/create'
    get 'favorites/destroy'
  end
  namespace :public do
    get 'maps/show'
  end
  get 'maps/show'
  namespace :public do
    get 'hospitals/new'
    get 'hospitals/index'
    get 'hospitals/show'
    get 'hospitals/create'
    get 'hospitals/update'
  end
  get 'hospitals/new'
  get 'hospitals/index'
  get 'hospitals/show'
  get 'hospitals/create'
  get 'hospitals/update'
  namespace :public do
    get 'reviews/new'
    get 'reviews/crate'
    get 'reviews/edit'
    get 'reviews/update'
    get 'reviews/destroy'
  end
  namespace :public do
    get 'comments/create'
    get 'comments/destroy'
  end
  get 'comments/create'
  get 'comments/destroy'
  namespace :public do
    resources :users do
      collection do
        get :mypage
        get :publish_unpublish
        get :unsubcribe
        get :withdraw
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
