class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false, limit: 70
      t.text :desc, limit: 210
      t.integer :qty, default: 0 
      t.decimal :retail_price, null: false
      t.decimal :wholesale_price, null: false
      t.string :supplier, null: false, limit: 70
      t.string :variations, array: true, default: []

      t.timestamps
    end
    add_index :items, :name, unique: true
  end
end
