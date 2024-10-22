class Store < ApplicationRecord
  has_many :items, dependent: :destroy
  validates :name, :address, presence: true
  validates :name, uniqueness: true
end
