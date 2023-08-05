# app/controllers/followings_controller.rb

class FollowingsController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    # POST /follow_user
    def follow_user
      user_id = AuthToken.find_user_id_by_token(params[:token])
      user_follower_id = user_id # The logged-in user follows another user
      following_user_id = params[:user_id] # The user to be followed
  
      # Check if the user to be followed exists
      following_user = User.find_by(id: following_user_id)
      unless following_user
        render json: { error: "User not found" }, status: :unprocessable_entity
        return
      end
  
      # Check if the user is already being followed
      if Following.exists?(user_follower_id: user_follower_id, user_id: following_user_id)
        render json: { message: "User is already being followed" }, status: :ok
        return
      end
  
      # Create the following record
      following = Following.new(
        user_follower_id: user_follower_id,
        user_id: following_user_id
      )
  
      if following.save
        # Increment the number of followers for the followed user
        following_user.increment!(:number_of_followers)
  
        render json: { message: "User followed successfully" }, status: :created
      else
        render json: { error: following.errors.full_messages.join(", ") }, status: :unprocessable_entity
      end
    end
    def unfollow_user
        user_id = AuthToken.find_user_id_by_token(params[:token])
        user_follower_id = user_id # The logged-in user who is currently following
        following_user_id = params[:user_id] # The user to be unfollowed
    
        # Check if the user to be unfollowed exists
        following_user = User.find_by(id: following_user_id)
        unless following_user
          render json: { error: "User not found" }, status: :unprocessable_entity
          return
        end
    
        # Check if the user is already not being followed
        following = Following.find_by(user_follower_id: user_follower_id, user_id: following_user_id)
        unless following
          render json: { message: "User is not being followed" }, status: :ok
          return
        end
    
        if following.destroy
          # Decrement the number of followers for the unfollowed user
          following_user.decrement!(:number_of_followers)
    
          render json: { message: "User unfollowed successfully" }, status: :ok
        else
          render json: { error: "Failed to unfollow user" }, status: :unprocessable_entity
        end
      end

      def list_followings
        user_id = AuthToken.find_user_id_by_token(params[:token])
        user = User.find(user_id)
        followings = user.followings
    
        render json: followings, status: :ok
      end

      def is_following
        user_id = AuthToken.find_user_id_by_token(params[:token])
        user = User.find(user_id)
        user_id = params[:user_id]
    
        # Check if the user is following the specified user
        is_following = user.followers.exists?(user_follower_id: user_id)
    
        render json: { is_following: is_following }
      end
    
  end
  