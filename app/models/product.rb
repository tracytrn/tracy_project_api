# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string           not null
#  price       :float            not null
#  quantity    :integer          default(1), not null
#  thumbnail   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_products_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Product < ApplicationRecord
  belongs_to :user
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  accepts_nested_attributes_for :product_categories, allow_destroy: true

  scope :search_by_name, ->(keyword) { where('name ILIKE ?', "%#{keyword}%") }
  scope :sorted_by_latest, -> { order(created_at: :DESC) }
end
