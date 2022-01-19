class CreateItemsTagsJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :items, :tags do |t|
      t.index [:item_id, :tag_id], unique: true
    end
  end
end
