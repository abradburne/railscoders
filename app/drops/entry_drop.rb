class EntryDrop < Liquid::Drop
  def initialize(entry)
    @entry = entry
  end

  def title
    @entry[:title]
  end

  def body
    @entry[:body]
  end

  def comments_count
    @entry[:comments_count]
  end

  def permalink
    "/users/#{@entry.user.id}/entries/#{@entry.id}"
  end

  def comment_post_url
    "/users/#{@entry.user.id}/entries/#{@entry.id}/comments"
  end
end