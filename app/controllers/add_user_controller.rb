# app/controllers/add_user_controller.rb

class AddUserController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    # POST /add_user
    def create
      user = User.new(user_name: params[:user_name],
                      user_password: params[:user_password],
                      email: params[:email],
                      number_of_followers: params[:number_of_following])
  
      if user.save
        render json: { message: "User created successfully!" }, status: :created
      else
        render json: { error: "Failed to create user.", errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
  