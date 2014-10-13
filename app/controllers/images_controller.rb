class ImagesController < ApplicationController
  def new
    @gallery = find_gallery
    @image = Image.new
  end

  def create
    
    @gallery = find_gallery

   # @image = Image.new(image_params)
    #@image.gallery_id = params[:gallery_id]

    @image = @gallery.images.build(image_params)

    if @image.save
      redirect_to @gallery  
    else
      render :new
    end
  end

  def show
    @gallery = find_gallery
    @image = @gallery.images.find(params[:id])
  end

  def edit
    @gallery = find_gallery
    @image = @gallery.images.find(params[:id])
  end

  def update
    gallery = find_gallery
    image = Image.find(params[:id])
    image.update(image_params)
    if @image.update(image_params)
      redirect_to @gallery 
    else
      render :edit
    end
  end

  def destroy
    gallery = find_gallery
    image = Image.find(params[:id])
    image.destroy
    redirect_to gallery_path(gallery)

  end

  private

  def image_params
    params.require(:image).permit(:name, :description, :url)
  end

  def find_gallery
    Gallery.find(params[:gallery_id])
  end
end
