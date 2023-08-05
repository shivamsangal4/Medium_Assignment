# db/migrate/2023xxxxxxx_create_versions.rb

class CreateVersions < ActiveRecord::Migration[7.0]
  def change
    create_table :versions do |t|
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true
      t.binary :post_img
      t.string :title
      t.string :topic
      t.date :post_date
      t.text :text
      t.integer :number_likes, default: 0
      t.integer :number_comm, default: 0
      t.integer :number_of_views, default: 0
      t.integer :total_reading_time, default: 0

      t.timestamps
    end
  end
end
