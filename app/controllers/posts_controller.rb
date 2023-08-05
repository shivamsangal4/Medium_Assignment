
class PostsController < ApplicationController
 

  def index
    @posts = Post.all.map do |post|
      user = User.find(post.user_id)
      {
        id: post.id,
        user_id: post.user_id,
        user_name: user.user_name,
        number_of_followers: user.number_of_followers,            # Add user_name from User table to each post
        title: post.title,
        topic: post.topic,
        post_date: post.post_date,
        text: post.text,
        subtitle: post.subtitle,
        number_likes: post.number_likes,
        number_comm: post.number_comm,
        number_of_views: post.number_of_views,
        total_reading_time: post.total_reading_time,
        created_at: post.created_at,
        updated_at: post.updated_at
      }
    end
    render json: @posts
  end
  def getuserpost
    user_id = AuthToken.find_user_id_by_token(params[:token])
    requested_user = params[:user_id]
    user = User.find(requested_user)
    posts = user.posts.map do |post|
      {
        id: post.id,
        user_id: post.user_id,
        user_name: user.user_name,
        title: post.title,
        topic: post.topic,
        post_date: post.post_date,
        text: post.text,
        subtitle: post.subtitle,
        number_likes: post.number_likes,
        number_comm: post.number_comm,
        number_of_views: post.number_of_views,
        total_reading_time: post.total_reading_time,
        created_at: post.created_at,
        updated_at: post.updated_at,
        is_requested_user: post.user_id == user_id.to_i
      }
    end

    render json: posts
  end
    def top_10_by_likes
    # Fetch the top 10 posts by likes in descending order.
    top_10_posts = Post.order(number_likes: :desc).limit(10)

    formatted_posts = top_10_posts.map do |post|
      {
        id: post.id,
        user_id: post.user_id,
        user_name: post.user.user_name,
        number_of_followers: post.user.number_of_followers,
        title: post.title,
        topic: post.topic,
        post_date: post.post_date,
        text: post.text,
        subtitle: post.subtitle,
        number_likes: post.number_likes,
        number_comm: post.number_comm,
        number_of_views: post.number_of_views,
        total_reading_time: post.total_reading_time,
        created_at: post.created_at,
        updated_at: post.updated_at
      }
    end

    render json: formatted_posts, status: :ok
    end

    def top_recomended_by_like
      topic = params[:topic]
      top_posts = Post.where(topic: topic).order(number_likes: :desc).limit(10)

      formatted_posts = top_posts.map do |post|
        {
          id: post.id,
          user_id: post.user_id,
          user_name: post.user.user_name,
          number_of_followers: post.user.number_of_followers,
          title: post.title,
          topic: post.topic,
          post_date: post.post_date,
          text: post.text,
          subtitle: post.subtitle,
          number_likes: post.number_likes,
          number_comm: post.number_comm,
          number_of_views: post.number_of_views,
          total_reading_time: post.total_reading_time,
          created_at: post.created_at,
          updated_at: post.updated_at
        }
      end
  
      render json: formatted_posts, status: :ok
    end
    
    def posts_by_similar_author
      user_id = params[:user_id]
      user_topics = Post.where(user_id: user_id).pluck(:topic)
      posts_with_same_topics = Post.where(topic: user_topics).includes(:user)
  
      formatted_posts = posts_with_same_topics.map do |post|
        {
          id: post.id,
          user_id: post.user_id,
          user_name: post.user.user_name,
          number_of_followers: post.user.number_of_followers,
          title: post.title,
          topic: post.topic,
          post_date: post.post_date,
          text: post.text,
          subtitle: post.subtitle,
          number_likes: post.number_likes,
          number_comm: post.number_comm,
          number_of_views: post.number_of_views,
          total_reading_time: post.total_reading_time,
          created_at: post.created_at,
          updated_at: post.updated_at
        }
      end
  
      render json: formatted_posts, status: :ok
    end

    def show
      post = Post.find(params[:post_id])
      user = post.user
  
      render json: {
        id: post.id,
        user_id: post.user_id,
        user_name: user.user_name,
        number_of_followers: user.number_of_followers,
        title: post.title,
        topic: post.topic,
        post_date: post.post_date,
        text: post.text,
        subtitle: post.subtitle,
        number_likes: post.number_likes,
        number_comm: post.number_comm,
        number_of_views: post.number_of_views,
        total_reading_time: post.total_reading_time,
        created_at: post.created_at,
        updated_at: post.updated_at
      }
    end
  end
  