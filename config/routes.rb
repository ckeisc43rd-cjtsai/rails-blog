Rails.application.routes.draw do
  mathjax 'mathjax'
  get 'home/index'
  default_url_options host: 'ruby.cjtsai.com'
  default_url_options protocol: :https
  devise_for :users, controllers: { registrations: 'users/registrations' }
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check
  #get "/blog_posts/new", to: "blog_posts#new", as: :new_blog_post
  #get "/blog_posts/:id/edit", to: "blog_posts#edit", as: :edit_blog_post
  #get "/blog_posts/:id", to: "blog_posts#show", as: :blog_post
  #post "/blog_posts", to: "blog_posts#create", as: :blog_posts
  #patch "/blog_posts/:id", to: "blog_posts#update"
  #delete "/blog_posts/:id", to: "blog_posts#destroy"
  resources :problems, only: [:index]
  
  resources :user_problems, only: [:create, :update] do
    member do
      post :advance
    end
  end

  resources :blog_posts do
    resources :comments
  end

  resources :users, only: [] do
    resources :blog_posts, only: [:index]
  end
  # Defines the root path route ("/")
   root "blog_posts#index"
end
