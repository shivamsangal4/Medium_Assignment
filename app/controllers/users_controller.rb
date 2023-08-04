class UsersController < ApplicationController
    # GET /users/:id/following
    def following
      user = User.find(params[:id])
  
      # Retrieve the list of users that the given user is following.
      following_list = user.followings
  
      render json: following_list
    rescue ActiveRecord::RecordNotFound
      render json: { error: "User not found" }, status: :not_found
    end
  end