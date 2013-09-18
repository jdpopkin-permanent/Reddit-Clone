class CreateLinkSubs < ActiveRecord::Migration
  def change
    create_table :link_subs do |t|
      t.integer :link_id, index: true
      t.integer :sub_id, index: true

      t.timestamps
    end
  end
end
