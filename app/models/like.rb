# app/models/like.rb

class Like < ApplicationRecord
    belongs_to :post
    belongs_to :user
  
    # Add any additional associations, validations, or model logic here
  end
  