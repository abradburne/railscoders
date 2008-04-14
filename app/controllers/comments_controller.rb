class CommentsController < ApplicationController
  before_filter :login_required  

  def create
    @entry = Entry.find_by_user_id_and_id(params[:user_id], params[:entry_id])
    @comment = Comment.new(:user_id => @logged_in_user.id, :body => params[:comment][:body])

    if @entry.comments << @comment
      flash[:notice] = 'Comment was successfully created.'
      Notifier.deliver_new_comment_notification(@comment)     
      redirect_to entry_path(:user_id => @entry.user, :id => @entry)
    else
     render :controller => 'entries', :action => 'show', :user_id => @entry.user, :id => @entry
    end
  end

  def destroy
    @entry = Entry.find_by_user_id_and_id(@logged_in_user.id, params[:entry_id], :include => :user)
    @comment = @entry.comments.find(params[:id])
    @comment.destroy

    redirect_to entry_path(:user_id => @entry.user.id, :id => @entry.id)
  end
end
