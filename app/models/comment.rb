class Comment < ActiveRecord::Base
  include ActsAsCommentable::Comment
  default_scope -> { order('created_at ASC') }

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user
  belongs_to :commentable, :polymorphic => true

  validates :comment, presence: true

  def comment_id
    Digest::MD5.hexdigest(ip.to_s).to_s[0..10]
  end
end
