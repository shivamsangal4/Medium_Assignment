# app/controllers/authentication_controller.rb

class AuthenticationController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    # POST /authenticate
    def login
        user = User.find_by(email: params[:email])
    
        if user && user.user_password == params[:user_password]
          render json: { message: "Login successful!" }, status: :ok
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end
  end
  