# app/models/post.rb

class Post < ApplicationRecord
    belongs_to :user
    # Add any additional associations, validations, or model logic here
    has_many :likes
    has_many :comments
  end
  