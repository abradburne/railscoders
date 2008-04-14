class UsertemplatesController < ApplicationController
  before_filter :login_required
  def index
    @usertemplates = @logged_in_user.usertemplates.find(:all)

    if @usertemplates.empty?
      @logged_in_user.usertemplates << Usertemplate.new(:name => 'blog_index',
                                                        :body => '')
      @logged_in_user.usertemplates << Usertemplate.new(:name => 'blog_entry',
                                                        :body => '')
      @usertemplates = @logged_in_user.usertemplates.find(:all)
    end
  end

  def edit
    @usertemplate = @logged_in_user.usertemplates.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'index'
  end

  def update
    @usertemplate = @logged_in_user.usertemplates.find(params[:id])
    if @usertemplate.update_attributes(params[:usertemplate])
      flash[:notice] = 'Template was successfully updated.'
      redirect_to usertemplates_path
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'index'
  end
end
