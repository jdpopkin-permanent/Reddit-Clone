class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :name, index: true
      t.integer :moderator

      t.timestamps
    end
  end
end
