class CreateDrafts < ActiveRecord::Migration[6.1]
  def change
    create_table :drafts do |t|
      t.references :user, foreign_key: true # This sets up a foreign key to the 'users' table
      t.string :post_img
      t.string :title
      t.string :topic
      t.text :text

      t.timestamps
    end

    # Remove the following line (draft_id is not required as it's automatically created by Rails)
    # add_index :drafts, :draft_id, unique: true
  end
end
