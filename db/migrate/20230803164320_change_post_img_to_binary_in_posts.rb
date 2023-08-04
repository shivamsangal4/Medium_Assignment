# db/migrate/yyyyymmddhhmmss_change_post_img_to_binary_in_posts.rb

class ChangePostImgToBinaryInPosts < ActiveRecord::Migration[7.0]
  def up
    change_column :posts, :post_img, :binary
  end

  def down
    change_column :posts, :post_img, :string
  end
end
