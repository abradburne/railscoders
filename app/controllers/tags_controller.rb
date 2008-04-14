class TagsController < ApplicationController
  def index
    @tags = Photo.tag_counts(:order => 'name')
  end
  
  def show
    @photos = Photo.find_tagged_with(params[:id])
  end
end
