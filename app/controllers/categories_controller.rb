class CategoriesController < ApplicationController
  before_filter :check_editor_role, :except => [:index, :show]
  
  def index
    @categories = Category.find(:all)
    respond_to do |wants|
      wants.html
      wants.xml { render :xml => @categories.to_xml }
    end
  end

  def show
    @category = Category.find(params[:id])
    respond_to do |wants|
     wants.html { redirect_to category_articles_url(:category_id => @category.id) }
     wants.xml { render :xml => @category.to_xml }
    end
  end
  
  def new
    @category = Category.new
  end

  def create
    @category = Category.create(params[:category])
    respond_to do |wants|
      wants.html { redirect_to admin_categories_url }
      wants.xml { render :xml => @category.to_xml }
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update_attributes(params[:category])
    respond_to do |wants|
      wants.html { redirect_to admin_categories_url }
      wants.xml { render :xml => @category.to_xml }
    end
  end

  def destroy
    @category = Category.find(params[:id])    
    @category.find(params[:id]).destroy
    respond_to do |wants|
      wants.html { redirect_to admin_categories_url }
      wants.xml { render :nothing => true }
    end
  end

  def admin
    @categories = Category.find(:all)
    respond_to do |wants|
      wants.html
      wants.xml { render :xml => @categories.to_xml }
    end    
  end
end
