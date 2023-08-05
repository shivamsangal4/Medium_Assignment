# app/controllers/add_user_controller.rb

class AddUserController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    # POST /add_user
    def create
      user = User.new(user_name: params[:user_name],
                      password_confirmation: params[:password_confirmation],
                      password: params[:password],
                      email: params[:email],
                      number_of_followers: params[:number_of_followers])
      
      if user.save
        render json: { message: "User created successfully!" }, status: :created
      else
        render json: { error: "Failed to create user.", errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    user_id = AuthToken.find_user_id_by_token(params[:token])
      credits = 0
      purchase_end_time = Date.today + 30.days
  
      # Create the new subscription
      subscription = Subscription.new(
        user_id: user_id,
        credits: credits,
        view_count: 1,
        purchased_end_time: purchase_end_time
      )
  
      if subscription.save
        render json: { message: "Subscription added successfully!" }, status: :created
      else
        render json: { error: subscription.errors.full_messages.join(", ") }, status: :unprocessable_entity
      end
    end
  end
  