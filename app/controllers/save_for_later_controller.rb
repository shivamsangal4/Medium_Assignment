# app/controllers/posts_controller.rb

class SaveForLaterController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    # ... (other methods)
  
    # POST /posts/:id/add_to_save_for_later
    def add_to_save_for_later
      user_id = AuthToken.find_user_id_by_token(params[:token])
      post = Post.find_by(id: params[:post_id])
  
      if post && user_id
        SaveForLater.create(user_id: user_id, post_id: post.id)
        render json: { message: "Post added to Save For Later successfully!" }, status: :ok
      else
        render json: { error: "Post not found or Invalid token" }, status: :unprocessable_entity
      end
    end
  
    # POST /posts/:id/remove_from_save_for_later
    def remove_from_save_for_later
      user_id = AuthToken.find_user_id_by_token(params[:token])
      post = Post.find_by(id: params[:post_id])
  
      if post && user_id
        save_for_later = SaveForLater.find_by(user_id: user_id, post_id: post.id)
        save_for_later.destroy if save_for_later
        render json: { message: "Post removed from Save For Later successfully!" }, status: :ok
      else
        render json: { error: "Post not found or Invalid token" }, status: :unprocessable_entity
      end
    end

    def save_for_later
      user_id = AuthToken.find_user_id_by_token(params[:token])
    user = User.find_by(id: user_id)

    if user
      save_for_later_posts = user.save_for_laters
      render json: save_for_later_posts
    else
      render json: { error: "Invalid token or user not found" }, status: :unprocessable_entity
    end
    end

    def is_saved_for_later
      user_id = AuthToken.find_user_id_by_token(params[:token])
    user = User.find_by(id: user_id)
      post_id = params[:post_id]
  
      # Check if the post is saved for later by the specified user
      is_saved = user.save_for_later.exists?(post_id: post_id)
  
      render json: { saved: is_saved }
    end
  end
  