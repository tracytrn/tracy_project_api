class ChangeUserIdInProductsToOptional < ActiveRecord::Migration[7.0]
  def change
    change_column :products, :user_id, :bigint, null: true
  end
end
