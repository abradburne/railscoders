require File.dirname(__FILE__) + '/../test_helper'

class NotifierTest < Test::Unit::TestCase
  FIXTURES_PATH = File.dirname(__FILE__) + '/../fixtures'
  CHARSET = "utf-8"
  fixtures :entries, :comments, :users

  include ActionMailer::Quoting

  def setup
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []

    @expected = TMail::Mail.new
    @expected.set_content_type "text", "plain", { "charset" => CHARSET }
    @expected.mime_version = '1.0'
  end
  
  def test_comment_notify
    comment = Comment.find(1)
    response = Notifier.create_new_comment_notification(comment)
    assert_equal "A new comment has been left on your blog", response.subject
    assert_match /Hi #{comment.entry.user.username}/, response.body
    assert_match /The comment was left by '#{comment.user.username}' at #{comment.created_at.to_s(:short)}/, response.body
    assert_match /go to http:\/\/railscoders.net\/users\/1\/entries\/1/, response.body
  end

  private
    def read_fixture(action)
      IO.readlines("#{FIXTURES_PATH}/notifier/#{action}")
    end

    def encode(subject)
      quoted_printable(subject, CHARSET)
    end
end
