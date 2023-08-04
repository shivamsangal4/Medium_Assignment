
class PostsController < ApplicationController
 

    def index
      @posts = Post.all
      render json: @posts
    end
    def getuserpost
      user = User.find(params[:user_id])
      posts = user.posts

      render json: posts
    end
    def top_10_by_likes
    # Fetch the top 10 posts by likes in descending order.
    top_10_posts = Post.order(number_likes: :desc).limit(10)

    render json: top_10_posts
    end

    
  end
  