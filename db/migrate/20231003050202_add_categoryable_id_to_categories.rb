class AddCategoryableIdToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :categoryable_id, :integer
    add_column :categories, :categoryable_type, :string
  end
end
