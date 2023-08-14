# db/migrate/YYYYMMDDHHMMSS_create_versions.rb

class CreateVersions < ActiveRecord::Migration[7.0]
  def change
    create_table :versions do |t|
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true
      t.string :title
      t.string :subtitle
      t.text :text
      t.string :topic
      t.string :imageURL
      t.string :version
      t.string :action

      t.timestamps
    end
  end
end
