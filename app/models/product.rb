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
  has_many :categories, through: :product_categories

  scope :search_by_name, ->(keyword) do
    where('name ILIKE ?', "%#{keyword}%")
  end

  scope :sorted_by_latest, -> { order(created_at: :DESC) }

  def self.filter_products(params)
    products = Products.all
    products = products.search_by_name(params[:keyword]) if params[:keyword].present?
    products = products.sorted_by_latest
    products
  end
end
