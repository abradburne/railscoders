class UserTagsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @tags = @user.photos.tag_counts(:order => 'name')
  end

  def show
    @user = User.find(params[:user_id])
    @photos = @user.photos.find_tagged_with(params[:id])
  end
end
