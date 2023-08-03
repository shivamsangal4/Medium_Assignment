class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :post, foreign_key: true # This sets up a foreign key to the 'posts' table
      t.references :user, foreign_key: true # This sets up a foreign key to the 'users' table
      t.text :comment
      t.timestamps
    end

  end
end
