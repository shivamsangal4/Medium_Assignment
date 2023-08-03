# app/models/following.rb

class Following < ApplicationRecord
    belongs_to :user_follower, class_name: 'User', foreign_key: 'user_follower_id'
    belongs_to :user
  
    # Add any additional associations, validations, or model logic here
  end
  