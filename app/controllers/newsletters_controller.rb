class NewslettersController < ApplicationController
  before_filter :check_administrator_role
  
  # GET /newsletters
  def index
    @newsletters = Newsletter.find(:all)
  end

  # GET /newsletters/1
  def show
    @newsletter = Newsletter.find(params[:id])
  end

  # GET /newsletters/new
  def new
    @newsletter = Newsletter.new
  end

  # GET /newsletters/1;edit
  def edit
    @newsletter = Newsletter.find_by_id_and_sent(params[:id], false)
  end

  # POST /newsletters
  def create
    @newsletter = Newsletter.new(params[:newsletter])

    if @newsletter.save
      flash[:notice] = 'Newsletter was successfully created.'
      redirect_to newsletter_path(@newsletter)
    else
      render :action => "new"
    end
  end

  # PUT /newsletters/1
  def update
    @newsletter = Newsletter.find_by_id_and_sent(params[:id], false)

    if @newsletter.update_attributes(params[:newsletter])
      flash[:notice] = 'Newsletter was successfully updated.'
      redirect_to newsletter_path(@newsletter)
    else
      render :action => "edit"
    end
  end

  # DELETE /newsletters/1
  def destroy
    @newsletter = Newsletter.find_by_id_and_sent(params[:id], false)
    @newsletter.destroy

    redirect_to newsletters_path
  end
  
  # PUT /newsletters/1;send
  def sendmails
    newsletter = Newsletter.find_by_id_and_sent(params[:id], false)
    users = User.find(:all)
    users.each do |user|
      Notifier.deliver_newsletter(user, @newsletter)
    end
    newsletter.update_attribute('sent', true)
    redirect_to newsletters_path
  end
  
end
