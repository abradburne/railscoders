class PagesController < ApplicationController
  before_filter :check_administrator_role, :except => :show

  def index
    @pages = Page.find(:all)
  end
	
  def show
    @page = Page.find(params[:id].to_i)
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(params[:page])
    @page.save!
    flash[:notice] = 'Page saved'
    redirect_to :action => 'index'
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end

  def edit
    @page = Page.find(params[:id].to_i)
  end

  def update
    @page = Page.find(params[:id].to_i)
    @page.attributes = params[:page]
    @page.save!
    flash[:notice] = "Page updated"
    redirect_to :action => 'index'
  rescue
    render :action => 'edit'
  end

  def destroy
    @page = Page.find(params[:id].to_i)
    if @page.destroy
      flash[:notice] = "Page deleted"
    else
      flash[:error] = "There was a problem deleting the page"
    end
    redirect_to :action => 'index'
  end
end
