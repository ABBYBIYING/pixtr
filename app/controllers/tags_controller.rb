class TagsController < ApplicationController
  def show
    @tag = params[:id]
    @images = Image.tagged_with(@tag)
  end
end
