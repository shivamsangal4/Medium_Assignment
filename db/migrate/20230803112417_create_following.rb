# db/migrate/<timestamp>_create_following.rb

class CreateFollowing < ActiveRecord::Migration[6.1]
  def change
    create_table :followings do |t|
      t.references :user_follower, foreign_key: { to_table: :users } # This sets up a foreign key to the 'users' table
      t.references :user, foreign_key: true # This sets up a foreign key to the 'users' table

      t.timestamps
    end
  end
end
