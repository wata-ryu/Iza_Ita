Rails.application.routes.draw do
  namespace :admin do
    get 'comments/destroy'
  end
  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
    get 'users/update'
    get 'users/withdraw'
  end
  namespace :admin do
    get 'genres/index'
    get 'genres/show'
    get 'genres/edit'
    get 'genres/update'
  end
  namespace :admin do
    get 'posts/index'
    get 'posts/show'
    get 'posts/destroy'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    #get 'comments/create'
    #get 'comments/destroy'
    resources :comments, only: [:create, :destroy]
  end
  namespace :public do
    #get 'posts/new'
    #get 'posts/create'
    #get 'posts/index'
    #get 'posts/show'
    #get 'posts/edit'
    #get 'posts/update'
    #get 'posts/destroy'
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  end
  namespace :public do
    #get 'users/show'
    #get 'users/edit'
    #get 'users/update'
    get 'users/unsubscribe'
    get 'users/withdraw'
    resources :users, only: [:show, :edit, :update]
  end
  namespace :public do
    #get 'homes/top'
    root to: "homes#top"
  end
  
  # 顧客用
  # URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
