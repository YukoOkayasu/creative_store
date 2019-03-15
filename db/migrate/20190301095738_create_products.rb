class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.integer :price, null: false
      t.integer :genre_id, null: false
      t.text :introduce, null: false
      t.integer :stock, null: false
      t.timestamps
    end
  end
end
