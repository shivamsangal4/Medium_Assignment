class UploadPostsController < ApplicationController
    def new
      @post = Post.new
    end
  
    def create
      @post = Post.new(upload_post_params)
      if @post.save
        redirect_to @post, notice: 'Post was successfully created.'
      else
        render :new
      end
    end
  
    def show
      @post = Post.find(params[:id])
    end
  
    private
  
    def upload_post_params
      params.require(:post).permit(:user_id, :post_img, :title, :topic, :post_date, :text, :number_likes, :number_comm, :number_of_views, :total_reading_time, :subtitle)
    end
  end
  