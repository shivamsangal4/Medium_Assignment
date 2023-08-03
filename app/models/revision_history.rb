# app/models/revision_history.rb

class RevisionHistory < ApplicationRecord
    belongs_to :user
    belongs_to :post
  
    # Add any additional associations, validations, or model logic here
  end
  