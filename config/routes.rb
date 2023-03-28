Rails.application.routes.draw do

  root to: "homes#top"

  get "search" => "searches#search"

  namespace :admin do
    resources :posts, only: [:destroy]
  end

  namespace :admin do
    resources :users, only: [:index, :show] do
      #admin側からの論理削除機能、user側からと違いユーザーの指定が必要なのでここにネストする
      get :unsubscribe
      patch :withdraw
    end
  end

  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
  end

  namespace :admin do
    resources :posts, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
    end
  end

  namespace :admin do
    #root to: "homes#top"
  end

  namespace :public do
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      #いいね機能。単数形にすると、/:idがURLに含まれなくなる(1人のユーザーは1つの投稿に対して1回しかいいねできないという仕様であるため)
      resource :bookmarks, only: [:create, :destroy]
      #コメントは何度もできるように複数形
      resources :comments, only: [:create, :destroy]
    end
  end

  namespace :public do
    get 'users/unsubscribe'
    patch 'users/withdraw'
    resources :users, only: [:show, :edit, :update] do
    get 'users/favorite'
      get :bookmarks, on: :collection
    end
  end

  namespace :public do
    #root to: "homes#top"
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