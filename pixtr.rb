
require "sinatra"
require "active_record"

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database:"photo_gallery"
  )

class Gallery < ActiveRecord::Base
  has_many :images
end

class Image < ActiveRecord::Base
  belongs_to :gallery
end

get "/" do
  @galleries = Gallery.all  
  erb :index
end

get "/galleries/:id" do
   @gallery = Gallery.find(params[:id]) 
   @images = @gallery.images
  erb :gallery
end 

get "/galleries/new" do
  erb :gallery_new
end

post "/galleries" do
  gallery = Gallery.create(params[:gallery])

  redirect "/galleries/#{gallery.id}"
end

get "/galleries/:id/edit" do
  @gallery = Gallery.find(params[:id]) 
  erb :gallery_edit
end

patch "/galleries/:id" do
  @gallery = Gallery.find(params[:id])
  @gallery.update(params[:gallery])

  redirect "/galleries/#{@gallery.id}" 
end

get "/galleries/:gallery_id/images/:id" do
  @image = Image.find(params[:id])
  erb :image
end

get "/galleries/:gallery_id/images/new" do
  @gallery_id = params[:gallery_id]
  erb :image_new
end

post "/galleries/:gallery_id/images" do
  image = Image.new(params[:image])
  image.gallery_id = params[:gallery_id]
  image.save
  redirect "/galleries/#{image.gallery_id}/images/#{image.id}" 
end

get "/galleries/:gallery_id/images/:id/edit" do
  @image = Image.find(params[:id])
  erb :image_edit
end

patch "/galleries/:gallery_id/images/:id" do
  image = Image.find(params[:id])
  image.update(params[:image])
  redirect "/galleries/#{image.gallery_id}/images/#{image.id}" 
end

delete "/galleries/:gallery_id/images/:id" do
  Image.find(params[:id]).destroy
  redirect "/galleries/#{params[:gallery_id]}"
end

delete "/galleries/:id" do
  gallery = Gallery.find(params[:id])

  gallery.images.each do|image|
    image.destroy
  end
  gallery.destroy
  redirect "/"
end