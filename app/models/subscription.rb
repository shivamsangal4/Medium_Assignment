# app/models/subscription.rb

class Subscription < ApplicationRecord
    belongs_to :user
  
    # Add any additional associations, validations, or model logic here
  end
  