# app/models/version.rb

class Version < ApplicationRecord
    belongs_to :post
    belongs_to :user
  
    # Add any additional validations or methods as needed
  end
  