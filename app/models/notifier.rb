class Notifier < ActionMailer::ARMailer
  def new_comment_notification(comment)
    blog_owner = comment.entry.user    
    recipients blog_owner.email_with_username

    from       "RailsCoders <system@railscoders.net>"
    subject    "A new comment has been left on your blog"
    body       :comment => comment,
               :blog_owner => blog_owner,
               :blog_owner_url => "http://railscoders.net/users/#{blog_owner.id}",
               :blog_entry_url => "http://railscoders.net/users/#{blog_owner.id}/entries/#{comment.entry.id}"
  end
  
  def newsletter(user, newsletter)
    recipients user.email
    from "RailsCoders <system@railscoders.net>"
    subject newsletter.subject
    body :body => newsletter.body, :user => user
  end
end
