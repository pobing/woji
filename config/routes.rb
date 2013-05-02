Woji::Application.routes.draw do
  resources :comments


  match '/signin', to: "sessions#new"
  match '/signout', to: "sessions#destroy"#, via: :delete
  match '/signup',  to: 'users#new'
  match 'home' => "static_pages#home"
  match 'help' => "static_pages#help"
  match 'about' => "static_pages#about"
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets
  resources :sites do
    collection do
      post 'add_by_md'
    end
  end
  resources :posts do
    # member do
    #  post 'post_message' 
    # end
    resources :comments
    collection do
        post 'post_tweet'
        post 'post_blog'
        get 'date_posts'
        get 'archives'
        get 'tag_posts'
      end
  end
  resources :categories 
    namespace :api do
      resources :users do
        collection {
        }
        member{
           post :update_pwd
        }
      end
    end
   root :to => 'posts#index'
end
