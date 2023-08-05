# app/controllers/payments_controller.rb
class PaymentsController < ApplicationController
    def create
      # Get payment details from the form
      card_number = params[:card_number]
      exp_month = params[:exp_month]
      exp_year = params[:exp_year]
      cvc = params[:cvc]
    amount = params[:amount]
      
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
  
      rescue Stripe::CardError => e
        # Payment failed
        flash[:alert] = e.message
      end

      redirect_to login_path
    end
  end
  