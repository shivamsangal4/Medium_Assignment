# db/migrate/<timestamp>_create_subscriptions.rb

class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, foreign_key: true # This sets up a foreign key to the 'users' table
      t.integer :credits
      t.integer :view_count
      t.date :purchased_end_time

      t.timestamps
    end
  end
end
