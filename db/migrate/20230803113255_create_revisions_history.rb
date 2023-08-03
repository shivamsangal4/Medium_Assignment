# db/migrate/<timestamp>_create_revisions_history.rb

class CreateRevisionsHistory < ActiveRecord::Migration[6.1]
  def change
    create_table :revisions_history do |t|
      t.references :user, foreign_key: true # This adds the FK constraint from User_table
      t.references :post, foreign_key: true # This adds the FK constraint from Post_table
      t.datetime :time_stamp

      t.timestamps
    end
  end
end
