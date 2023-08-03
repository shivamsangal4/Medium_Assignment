# app/models/save_for_later.rb

class SaveForLater < ApplicationRecord
    belongs_to :user
    belongs_to :post
  
    # Add any additional associations, validations, or model logic here
  end
  