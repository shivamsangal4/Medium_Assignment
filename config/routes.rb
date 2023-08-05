Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/posts', to: 'posts#index'

  get '/posts/get', to: 'posts#getuserpost'

  get '/posts/top_10_by_likes', to: 'posts#top_10_by_likes'

  get '/posts/recommended_posts', to: 'posts#top_recomended_by_like'

  get '/posts/similar_author', to: 'posts#posts_by_similar_author'

  get '/posts/one_post', to: 'posts#show'

  # get '/users/:id/following', to: 'users#following'

  resources :upload_posts, only: [:new, :create, :show]  # Use UploadPostsController
  
  post '/add_user', to: 'add_user#create'

  post '/login', to: 'sessions#login'

  post '/add_post', to: 'add_posts#create'
  
  delete '/delete_post', to: 'add_posts#destroy'

  delete '/update_post', to: 'add_posts#update'

  post '/add_post/add_reading_time', to: 'add_posts#update_reading_time'

  post '/add_likes', to: 'likes#create'

  post '/remove_likes', to: 'likes#destroy'

  post '/is_liked', to: 'likes#is_liked'

  post '/add_comment', to: 'comments#create'

  delete '/remove_comment', to: 'comments#destroy'

  get '/comments', to: 'comments#comments'

  post '/add_save_for_later', to: 'save_for_later#add_to_save_for_later'

  delete '/remove_save_for_later', to: 'save_for_later#remove_from_save_for_later'

  get '/save_for_laters', to: 'save_for_later#save_for_later'

  get '/save_for_laters/is_saved_for_later', to: 'save_for_later#is_saved_for_later'

  post '/followings/follow_user', to: 'followings#follow_user'

  post '/followings/unfollow_user', to: 'followings#unfollow_user'

  post '/followings', to: 'followings#list_followings'

  post '/followings/is_following', to: 'followings#is_following'

  post '/draft/add_draft', to: 'drafts#create'

  post '/draft/delete_draft', to: 'drafts#destroy'

  post '/draft', to: 'drafts#index'

  post '/subscriptions/create', to: 'subscriptions#create'

  post '/subscriptions/update_view_count', to: 'subscriptions#update_view_count'

  post '/subscriptions/update_credits', to: 'subscriptions#update_credits'

  post '/subscriptions/increment_views_and_decrease_view_count', to: 'subscriptions#increment_views_and_decrease_view_count'

  post '/subscriptions/set_credits', to: 'subscriptions#set_credits'
  # root to: 'welcome#index'  # Set a different default page (replace 'welcome#index' with the desired controller and action)
end
