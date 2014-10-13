class CommentsController < ApplicationController

def create
  @image = Image.find(params[:image_id])
  @comment = @image.comments.new(comment_params)
    if @comment.save
      redirect_to[@image.gallery @image]
    else
      render "images/show"
    end
end

end
