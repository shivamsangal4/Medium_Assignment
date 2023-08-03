# app/models/user.rb

class User < ApplicationRecord
    # Add any associations, validations, or model logic here
  
    has_many :posts
    has_many :likes
    has_many :comments
    has_many :followings, foreign_key: 'user_follower_id'
    has_many :subscriptions
    has_many :drafts
    has_many :revision_histories
    has_many :save_for_laters
  end
  