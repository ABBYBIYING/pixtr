 class GalleriesController < ApplicationController
  before_action :require_login, except: [:index]
  before_filter :require_permission, only: [:edit, :destroy]

  def index
    @galleries = Gallery.all
  end

  def new
    @gallery = Gallery.new
  end

  def create
    @gallery = current_user.galleries.new(gallery_params)

    if @gallery.save
      redirect_to @gallery
    else
      redirect_to root_path
    end
  end

  def show
    find_gallery
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

  def require_permission
    if current_user != Gallery.find(params[:id]).user
      redirect_to root_path
    end
  end
end

