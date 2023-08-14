

class VersionsController < ApplicationController
  skip_before_action :verify_authenticity_token


  def show_post_versions
   
    user_id = AuthToken.find_user_id_by_token(params[:token])
    
    
    post = Post.find_by(id: params[:post_id], user_id: user_id)
    if post.nil?
      render json: { error: "Post not found for the specified user" }, status: :not_found
      return
    end

    versions = post.versions.order(created_at: :desc)


    transformed_versions = versions.map do |version|
      {
        version_id: version.id,
        post_id: version.post_id,
        user_id: version.user_id,
        title: version.title,
        subtitle: version.subtitle,
        text: version.text,
        topic: version.topic,
        imageURL: version.imageURL,
        version: version.version,
        action: version.action,
        created_at: version.created_at
      }
    end

    render json: transformed_versions
  end
end
