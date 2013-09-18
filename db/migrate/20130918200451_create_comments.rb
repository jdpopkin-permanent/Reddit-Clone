class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :link_id, index: true
      t.integer :user_id
      t.integer :parent_comment_id, index: true
      t.text :body

      t.timestamps
    end
  end
end
