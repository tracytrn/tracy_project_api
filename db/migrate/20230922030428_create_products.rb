class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.float :price, null: false
      t.integer :quantity, null: false, default: 1
      t.text :description
      t.string :thumbnail
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
