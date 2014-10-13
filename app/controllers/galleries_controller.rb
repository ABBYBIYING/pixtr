 class GalleriesController < ApplicationController

  def index
    @galleries = Gallery.all
  end

  def show
    @gallery = Gallery.find(params[:id])
    @images = @gallery.images
  end

  def new
    @gallery = Gallery.new
  end

  def create
    @gallery = Gallery.new(gallery_params)
    if @gallery.save
      redirect_to gallery_path(@gallery)
    else
      render :new
    end
  end

  def update

    @gallery = Gallery.find(params[:id])
    @gallery.update(gallery_params)
    if @gallery.update(gallery_params)
      redirect_to @gallery
    else
      render :edit
    end
  end

  def edit
    @gallery = Gallery.find(params[:id])
  end

  def destroy
    gallery = Gallery.find(params[:id])
    gallery.destroy
    redirect_to galleries_path
  end

  private

  def gallery_params
    params.require(:gallery).permit(:name, :description, :cover_image)
  end
end

