class ImagesController < ApplicationController
  before_action :require_login, except: :show

  def new
    find_gallery
    @image = @gallery.images.new
  end

  def create
    find_gallery
    @image = @gallery.images.new(image_params)
    @image.user = current_user

    if @image.save
      redirect_to [@gallery,@image]
    else
      render :new
    end
  end

  def show
    find_gallery
    @image = @gallery.images.find(params[:id])
    @comment = Comment.new
  end

  def edit
    find_gallery
    @image = @gallery.images.find(params[:id])
  end

  def update
    find_gallery
    @image = @gallery.images.find(params[:id])

    if @image.update(image_params)
      redirect_to [@gallery, @image]
    else
      render :edit
    end
  end

  def destroy
    gallery = Gallery.find(params[:gallery_id])
    image = gallery.images.find(params[:id])
    image.destroy

    redirect_to gallery
  end

  private

  def image_params
    params.require(:image).permit(
      :name,
      :description,
      :url,
      :tag_list,
      group_ids:[]
      )
  end

  def find_gallery
    @gallery = Gallery.find(params[:gallery_id])
  end
end
