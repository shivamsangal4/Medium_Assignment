# db/migrate/yyyyymmddhhmmss_remove_post_img_from_posts.rb
class RemovePostImgFromPosts < ActiveRecord::Migration[6.0] # Change the version to match your Rails version
  def up
    remove_column :posts, :post_img
  end

  def down
    add_column :posts, :post_img, :binary
  end
end
