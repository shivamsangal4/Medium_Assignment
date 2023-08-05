class DraftsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        # Get user_id from the request parameters
        user_id = AuthToken.find_user_id_by_token(params[:token])
    
        # Find all drafts belonging to the user
        drafts = Draft.where(user_id: user_id)
    
        render json: drafts, status: :ok
      end
  
    # POST /drafts
    def create
      # Get details from the params
      user_id = AuthToken.find_user_id_by_token(params[:token])
      post_img = "";
      title = params[:title]
      topic = params[:topic]
      text = params[:text]
  
      # Create the new draft
      draft = Draft.new(
        user_id: user_id,
        post_img: post_img,
        title: title,
        topic: topic,
        text: text
      )
  
      if draft.save
        render json: { message: "Draft added successfully!" }, status: :created
      else
        render json: { error: draft.errors.full_messages.join(", ") }, status: :unprocessable_entity
      end
    end

    def destroy
        # Get user_id and draft_id from the request parameters
        user_id = AuthToken.find_user_id_by_token(params[:token])
        draft_id = params[:draft_id]
    
        # Find the draft to be deleted
        draft = Draft.find_by(id: draft_id, user_id: user_id)
    
        if draft.nil?
          render json: { error: "Draft not found or not authorized to delete" }, status: :not_found
        else
          draft.destroy
          render json: { message: "Draft deleted successfully!" }, status: :ok
        end
      end
  end
  