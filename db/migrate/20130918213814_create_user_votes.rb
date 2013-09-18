class CreateUserVotes < ActiveRecord::Migration
  def change
    create_table :user_votes do |t|
      t.integer :user_id, index: true
      t.integer :vote
      t.integer :link_id, index: true

      t.timestamps
    end
  end
end
