class Link < ActiveRecord::Base
  attr_accessible :body, :title, :url

  validates :title, presence: true
  validates :url, presence: true

  has_many :link_subs, class_name: "LinkSub", primary_key: :id,
           foreign_key: :link_id

  has_many :subs, through: :link_subs, source: :sub, inverse_of: :links

end
