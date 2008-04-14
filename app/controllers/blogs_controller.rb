class BlogsController < ApplicationController
  def index
    @entry_pages = Paginator.new(self, Entry.count, 10, params[:page])
    @entries = Entry.find(:all, 
                          :limit => @entry_pages.items_per_page,
                          :offset => @entry_pages.current.offset,                          
                          :order => 'entries.created_at DESC', 
                          :include => :user)
  end
end
