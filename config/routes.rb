Woji::Application.routes.draw do
  mount UeditorRails::Engine => '/ueditor'
  resources :comments
  match '/signin', to: "sessions#new"
  match '/signout', to: "sessions#destroy"#, via: :delete
  match '/signup',  to: 'users#new'
  match "/auth/:provider/callback", :to => 'sessions#auth'
  match 'home' => "static_pages#home"
  match 'contact' => "static_pages#contact"
  match 'about' => "static_pages#about"
  match '/manage/:action', :controller => "manage" , :as=>"manage"
  resources :users do
    member{
      post  :update_avatar
      post :remove_avatar
      get :download_avatar
        }
  end
  resources :files
  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets
  resources :sites do
    collection do
      post 'add_by_md'
    end
  end
  resources :posts do
    member do
#     get 'post_atom' 
    end
    resources :comments
    collection do
        post 'post_tweet'
        post 'post_blog'
        get 'date_posts'
        get 'archives'
        get 'tag_posts'
        get 'search'
        get 'month'
      end
  end
  resources :categories 
    namespace :api do
      resources :users do
        collection {
        }
        member{
           post :update_pwd
           # post  :update_avatar
        }
      end
  end

  resources :feedbacks, except: [:destroy]
  root :to => 'posts#index'
end
