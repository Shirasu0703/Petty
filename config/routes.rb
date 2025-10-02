Rails.application.routes.draw do
  get 'users/mypage'
  get 'users/edit'
  get 'users/show'
  get 'users/update'
  get 'users/publish_unpublish'
  get 'users/unsubcribe'
  get 'users/withdraw'
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  get "about", to: "homes#about", as: "about"
end
