 class GalleriesController < ApplicationController
  def index
    @galleries = Gallery.all
  end

  def new
    @gallery = Gallery.new
  end

  def show
    find_gallery
  end


  def create
    @gallery = Gallery.new(gallery_params)

    if @gallery.save
      redirect_to @gallery
    else
      render :new
    end
  end

  def edit
    find_gallery
  end

  def update
    find_gallery

    if @gallery.update(gallery_params)
      redirect_to @gallery
    else
      render :edit
    end
  end

  def destroy
    gallery = Gallery.find(params[:id])
    gallery.destroy

    redirect_to galleries_path
  end

  private

  def find_gallery
    @gallery = Gallery.find(params[:id])
  end

  def gallery_params
    params.require(:gallery).permit(:name, :description, :cover_image)
  end
end

