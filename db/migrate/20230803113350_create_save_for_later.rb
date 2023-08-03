# db/migrate/<timestamp>_create_save_for_later.rb

class CreateSaveForLater < ActiveRecord::Migration[6.1]
  def change
    create_table :save_for_later do |t|
      t.references :user, foreign_key: true # This adds the FK constraint from User_table
      t.references :post, foreign_key: true # This adds the FK constraint from Post_table
      t.datetime :time_stamp

      t.timestamps
    end
  end
end
