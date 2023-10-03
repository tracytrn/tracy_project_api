class RemoveCategoryableIdFromCategories < ActiveRecord::Migration[7.0]
  def change
    remove_column :categories, :categoryable_id, :integer
    remove_column :categories, :categoryable_type, :string
  end
end
