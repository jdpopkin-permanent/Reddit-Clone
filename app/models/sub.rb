class Sub < ActiveRecord::Base
  attr_accessible :moderator, :name

  validates :moderator, presence: true
  validates :name, presence: true

  belongs_to :user, class_name: "User", primary_key: :id, foreign_key: :moderator

  has_many :link_subs, class_name: "LinkSub", primary_key: :id, foreign_key: :sub_id

  has_many :links, through: :link_subs, source: :link, inverse_of: :subs


end
