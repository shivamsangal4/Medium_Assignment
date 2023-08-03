# db/seeds.rb

# Dummy data for likes
likes_data = [
    { post_id: 1, user_id: 2 },
    { post_id: 1, user_id: 3 },
    { post_id: 2, user_id: 1 },
    { post_id: 3, user_id: 2 },
    # Add more likes as needed
  ]
  
  # Insert likes data into the database
  likes_data.each do |like_data|
    Like.create(like_data)
  end
  