class CommentDrop < Liquid::Drop
  def initialize(comment)
    @comment = comment
  end

  def author
    @comment.user.username
  end

  def body
    @comment[:body]
  end

  def created_at
    @comment[:created_at]
  end
end