class Item < ApplicationRecord
  belongs_to :store
  has_many :ingredients, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :store_id }
  validates :price, numericality: { greater_than: 0 }

  scope :search_by_name, ->(name) { where("name ILIKE ?", "%#{name}%") }
  scope :filter_by_store, ->(store_id) { where(store_id: store_id) }
end
