# app/controllers/sessions_controller.rb

class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  # POST /login
  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = encode_token(user.id)
      user_id = user.id

      # Create or update the auth_token
      auth_token = user.auth_tokens.find_or_initialize_by(token: token)
      auth_token.save

      render json: { token: token , user_id: user_id}, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  private

  def encode_token(user_id)
    JWT.encode({ user_id: user_id }, Rails.application.secrets.secret_key_base)
  end
end
