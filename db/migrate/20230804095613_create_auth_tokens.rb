class CreateAuthTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :auth_tokens do |t|
      t.string :token
      t.integer :user_id

      t.timestamps
    end
    add_index :auth_tokens, :user_id
  end
end
