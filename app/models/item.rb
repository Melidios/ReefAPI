class Item < ApplicationRecord
  belongs_to :store
  has_many :ingredients, dependent: :destroy
  
  validates :name, presence: true, uniqueness: { scope: :store_id }
  validates :price, numericality: { greater_than: 0 }
end
