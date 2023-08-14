# app/models/post.rb

class Post < ApplicationRecord
    belongs_to :user
    # Add any additional associations, validations, or model logic here
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :versions, dependent: :destroy
    # has_one_attached :post_img
  end
  