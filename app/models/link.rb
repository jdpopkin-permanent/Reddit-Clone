class Link < ActiveRecord::Base
  attr_accessible :body, :title, :url, :sub_ids

  validates :title, presence: true
  validates :url, presence: true

  has_many  :link_subs, class_name: "LinkSub", primary_key: :id,
            foreign_key: :link_id

  has_many :subs, through: :link_subs, source: :sub, inverse_of: :links

  has_many  :comments, class_name: "Comment", primary_key: :id,
            foreign_key: :link_id

  has_many  :user_votes, class_name: "UserVote", primary_key: :id,
            foreign_key: :link_id

  has_many :voters, through: :user_votes, source: :user, inverse_of: :votes

  def sub_ids=(sub_ids)
    self.subs = sub_ids.map { |id| Sub.find(id) }
  end

  def comments_by_parent_id
    comments = Comment.where(link_id: self.id)
    #comments << nil
    comment_hash = {}

    comments.each do |comment|
      comment_hash[comment.id] = Comment.where(parent_comment_id: comment.id)
    end

    comment_hash[nil] = Comment.where(parent_comment_id: nil)

    comment_hash
  end

  def score
    total = 0
    UserVote.where(link_id: self.id).each { |uv| total += uv.vote }
    total
  end

end
