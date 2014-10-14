class CommentsController < ApplicationController
  before_action :require_login

  def create
    @image = Image.find(params[:image_id])
    @comment = @image.comments.create(comment_params)

    if @comment.save
        redirect_to [@image.gallery, @image]
       else
        render "images/show"
      end
  end

  def comment_params
    params.require(:comment).permit(:content).merge(user: current_user)
  end
end
