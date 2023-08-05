class SubscriptionsController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    # POST /subscriptions
    def create
      # Get details from the request parameters
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

    def update_view_count
        # Find all subscriptions
        subscriptions = Subscription.all
    
        subscriptions.each do |subscription|
          # Check if the subscription has not expired (purchase_end_time is in the future)
          if subscription.purchased_end_time >= Date.today
            # If it's a new day, reset the view_count to 0
            if subscription.updated_at.to_date < Date.today
              subscription.update(view_count: 0)
            end
    
            # Increment the view_count by 1

            subscription.update(view_count: subscription.credits+1)
          end
        end
    
        render json: { message: "View counts updated successfully!" }, status: :ok
      end

      def update_credits
        # Find all subscriptions with purchased_end_time in the past
        expired_subscriptions = Subscription.where("purchased_end_time < ?", Date.today)
    
        expired_subscriptions.each do |subscription|
          # Set the credits to 0 for expired subscriptions
          subscription.update(credits: 0)
        end
    
        render json: { message: "Credits updated successfully!" }, status: :ok
      end

      def increment_views_and_decrease_view_count
        user_id = AuthToken.find_user_id_by_token(params[:token])
        post_id = params[:post_id]
    
        post = Post.find_by(id: post_id)
        subscription = Subscription.find_by(user_id: user_id)
    
        if post && subscription
          post.increment!(:number_of_views)
          new_view_count = subscription.view_count - 1
          new_view_count = [new_view_count, 0].max # Ensure it doesn't go below 0
    
          subscription.update(view_count: new_view_count)
          render json: { message: "Number of views incremented and view count decreased successfully!", view_count: new_view_count }, status: :ok
        else
          render json: { error: "Post or Subscription not found for the given IDs" }, status: :not_found
        end
      end

      def set_credits
        user_id = AuthToken.find_user_id_by_token(params[:token])
            subscription = Subscription.find_by(user_id: user_id)
            return render json: { error: "Subscription not found for the user" }, status: :not_found unless subscription
        
            new_credits = params[:credits].to_i
            subscription.update(credits: new_credits)
        
            render json: { message: "Subscription credits updated successfully!" }, status: :ok
          end

  end
  