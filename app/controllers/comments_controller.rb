# app/controllers/comments_controller.rb

class CommentsController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    # POST /add_comment
    def create
      # Get details from the params
      user_id = AuthToken.find_user_id_by_token(params[:token])
      post_id = params[:post_id]
      comment_text = params[:comment]
  
      # Create the new comment
      comment = Comment.new(
        user_id: user_id,
        post_id: post_id,
        comment: comment_text
      )
  
      if comment.save
        # Increment the number_comm in the associated post
        post = Post.find_by(id: post_id)
        post.increment!(:number_comm) if post
  
        render json: { message: "Comment added successfully!" }, status: :created
      else
        render json: { error: comment.errors.full_messages.join(", ") }, status: :unprocessable_entity
      end
    end
  
    # DELETE /remove_comment
    def destroy
      # Get details from the params
      user_id = AuthToken.find_user_id_by_token(params[:token])
      comment_id = params[:comment_id]
  
      # Find and destroy the comment
      comment = Comment.find_by(id: comment_id, user_id: user_id)
  
      if comment
        # Decrement the number_comm in the associated post
        post = Post.find_by(id: comment.post_id)
        post.decrement!(:number_comm) if post
  
        comment.destroy
        render json: { message: "Comment removed successfully!" }, status: :ok
      else
        render json: { error: "Comment not found" }, status: :not_found
      end
    end
    def comments
        post = Post.find_by(id: params[:post_id])
    
        if post
          comments = post.comments
          render json: comments, status: :ok
        else
          render json: { error: "Post not found" }, status: :not_found
        end
      end
      
    # ... (other methods)
  end
  