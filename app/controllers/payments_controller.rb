# app/controllers/payments_controller.rb
class PaymentsController < ApplicationController
    def create
      # Get payment details from the form
      card_number = params[:card_number]
      exp_month = params[:exp_month]
      exp_year = params[:exp_year]
      cvc = params[:cvc]
    amount = params[:amount]

    user = User.find_by(email: params[:email])
      
      token = Stripe::Token.create({
        card: {
          number: card_number,
          exp_month: exp_month,
          exp_year: exp_year,
          cvc: cvc
        }
      })

      begin
        charge = Stripe::Charge.create({
          amount: amount,
          currency: 'usd',
          source: token,  # Pass the token to Stripe's API to charge the customer
          description: 'Payment for Order #123'  # Customize as needed
        })
  
        # Payment successful
        flash[:notice] = 'Payment successful!'
        done = 'success';

      rescue Stripe::CardError => e
        # Payment failed
        flash[:alert] = e.message
        done = 'failed'
      end
      if done == 'success'
        subscription = Subscription.create!(
          user_id: user.id,   
          amount: payment_amount,    
          expires_at: 30.days.from_now   
        )

      redirect_to login_path
    end
  end
  