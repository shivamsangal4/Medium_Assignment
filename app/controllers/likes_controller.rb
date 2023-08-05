# app/controllers/likes_controller.rb

class LikesController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    # POST /add_like
    def create
      # Get details from the params
      user_id = AuthToken.find_user_id_by_token(params[:token])
      post_id = params[:post_id]
  
      # Check if the like already exists for this user and post
      like = Like.find_by(user_id: user_id, post_id: post_id)
  
      if like
        render json: { error: "Like already exists" }, status: :unprocessable_entity
      else
        # Create the new like
        like = Like.new(
          user_id: user_id,
          post_id: post_id
        )
  
        # Increment the number_likes in the associated post
        post = Post.find_by(id: post_id)
        post.increment!(:number_likes) if post
  
        if like.save
          render json: { message: "Like added successfully!" }, status: :created
        else
          render json: { error: like.errors.full_messages.join(", ") }, status: :unprocessable_entity
        end
      end
    end
  
    def destroy
        # Get details from the params
        user_id = AuthToken.find_user_id_by_token(params[:token])
        post_id = params[:post_id]
    
        # Find and destroy the like
        like = Like.find_by(user_id: user_id, post_id: post_id)
    
        if like
          like.destroy
    
          # Decrement the number_likes in the associated post
          post = Post.find_by(id: post_id)
          post.decrement!(:number_likes) if post
    
          render json: { message: "Like removed successfully!" }, status: :ok
        else
          render json: { error: "Like not found" }, status: :not_found
        end
      end

      def is_liked
        post = Post.find(params[:post_id])
        user_id = AuthToken.find_user_id_by_token(params[:token])
    
        # Check if the user has liked the post
        is_liked = post.likes.exists?(user_id: user_id)
    
        render json: { liked: is_liked }
      end
    

  end
  