# app/controllers/add_posts_controller.rb

class AddPostsController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    # POST /add_post
    def create
      # Get details from the params
      user_id = AuthToken.find_user_id_by_token(params[:token])
      title = params[:title]
      topic = params[:topic]
      post_date = Date.today
      text = params[:text]
      subtitle = params[:subtitle]

      number_likes = 0
      number_comm = 0
      number_of_views = 0
      total_reading_time = 0
  
      # Create the new post
      post = Post.new(
        user_id: user_id,
        title: title,
        topic: topic,
        post_date: post_date,
        text: text,
        subtitle: subtitle,
        number_likes: number_likes,
        number_comm: number_comm,
        number_of_views: number_of_views,
        total_reading_time: total_reading_time
      )
      # version = Version.new(
      #   post_id: post.id,
      #   user_id: user_id,
      #   title: title,
      #   topic: topic,
      #   post_date: post_date,
      #   text: text,
      #   subtitle: subtitle,
      #   number_likes: number_likes,
      #   number_comm: number_comm,
      #   number_of_views: number_of_views,
      #   total_reading_time: total_reading_time)
        
      #   version.save
     
  
      if post.save
        render json: { message: "Post added successfully!" }, status: :created
      else
        render json: { error: post.errors.full_messages.join(", ") }, status: :unprocessable_entity
      end
    end


    def destroy
      post = Post.find_by(id: params[:post_id])
  
      if post.nil?
        render json: { error: "Post not found" }, status: :not_found
      else
        # Make sure only the owner of the post can delete it
        user_id = AuthToken.find_user_id_by_token(params[:token])
        if user_id == post.user_id
          post.destroy
          render json: { message: "Post deleted successfully" }, status: :ok
        else
          render json: { error: "Unauthorized to delete this post" }, status: :unauthorized
        end
      end
    end

def update
    post = Post.find_by(id: params[:post_id])

    if post.nil?
      render json: { error: "Post not found" }, status: :not_found
    else
      # Make sure only the owner of the post can update it
      user_id = AuthToken.find_user_id_by_token(params[:token])
      if user_id == post.user_id
        # Get updated details from the params
        title = params[:title]
        topic = params[:topic]
        text = params[:text]
        subtitle = params[:subtitle]

        # Update the post attributes
        post.update(
          title: title,
          topic: topic,
          text: text,
          subtitle: subtitle
        )

        render json: { message: "Post updated successfully" }, status: :ok
      else
        render json: { error: "Unauthorized to update this post" }, status: :unauthorized
      end
    end
  end
  def update_reading_time
    post = Post.find(params[:post_id])

    # Get the new reading time from params
    new_reading_time = params[:time].to_i

    # Calculate the new total_reading_time by adding the new reading time to the existing total_reading_time
    total_reading_time = post.total_reading_time.to_i + new_reading_time

    # Update the post with the new total_reading_time
    if post.update(total_reading_time: total_reading_time)
      render json: { message: "Total reading time updated successfully!" }, status: :ok
    else
      render json: { error: post.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  end
  