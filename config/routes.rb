Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/posts', to: 'posts#index'

  get '/:user_id/posts', to: 'posts#getuserpost'

  get '/posts/top_10_by_likes', to: 'posts#top_10_by_likes'

  get '/users/:id/following', to: 'users#following'

  resources :upload_posts, only: [:new, :create, :show]  # Use UploadPostsController
  
  post '/add_user', to: 'add_user#create'
  
  post '/authenticate', to: 'authentication#login'

  # root to: 'welcome#index'  # Set a different default page (replace 'welcome#index' with the desired controller and action)
end
