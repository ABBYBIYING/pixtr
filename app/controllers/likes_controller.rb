class LikesController < ApplicationController
  def create
    @image = Image.find(params[:image_id])
    current_user.liked_images << @image

    redirect_to [@image.gallery, @image]
  end

  def destroy
    @image = Image.find(params[:image_id])
    current_user.liked_images.delete(@image)

    redirect_to [@image.gallery, @image]
  end
end
