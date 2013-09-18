class Comment < ActiveRecord::Base
  attr_accessible :body, :link_id, :parent_comment_id, :user_id
end
