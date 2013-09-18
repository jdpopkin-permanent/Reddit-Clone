class Link < ActiveRecord::Base
  attr_accessible :body, :title, :url, :sub_ids

  validates :title, presence: true
  validates :url, presence: true

  has_many :link_subs, class_name: "LinkSub", primary_key: :id,
           foreign_key: :link_id

  has_many :subs, through: :link_subs, source: :sub, inverse_of: :links

  has_many :comments, class_name: "Comment", primary_key: :id,
          foreign_key: :link_id

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

end
