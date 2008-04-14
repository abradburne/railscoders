class Mobile::EntriesController < EntriesController
  layout 'mobile'
  
  def index
    @user = User.find(params[:user_id], :include => :usertemplates)
    @entry_pages = Paginator.new(self, @user.entries_count, 5, params[:page])
    @entries = @user.entries.find(:all, :order => 'created_at DESC',
                            :limit => @entry_pages.items_per_page,
                            :offset => @entry_pages.current.offset)
  end


  def show
    @user = User.find(params[:user_id], :include => :usertemplates)    
    @entry = Entry.find_by_id_and_user_id(params[:id], 
                          params[:user_id],
                          :include => [:comments => :user])
  end  
end