class AuthToken < ApplicationRecord
    belongs_to :user
    def self.find_user_id_by_token(token)
        auth_token = find_by(token: token)
        auth_token&.user_id
      end
  end