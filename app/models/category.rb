# == Schema Information
#
# Table name: categories
#
#  id               :bigint           not null, primary key
#  categorable_type :string
#  description      :text
#  name             :string           not null
#  thumbnail        :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  categorable_id   :integer
#  user_id          :bigint           not null
#
# Indexes
#
#  index_categories_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Category < ApplicationRecord
  belongs_to :user
  belongs_to :categorable, polymorphic: true, optional: true
  has_many :categories, as: :categorable
  has_many :products, through: :product_categories

  scope :search_by_name, ->(keyword) do
    where('name ILIKE ?', "%#{keyword}%")
  end

  scope :sorted_by_latest, -> { order(created_at: :DESC) }

end
