class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true # This adds the FK constraint from User_table
      t.string :post_img
      t.string :title
      t.string :topic
      t.date :post_date
      t.text :text
      t.integer :number_likes
      t.integer :number_comm
      t.integer :number_of_views
      t.integer :total_reading_time

      t.timestamps
    end
  end
end

