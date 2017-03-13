class Product < ApplicationRecord
  has_many :line_items
  has_many :orders, through: :line_items
  has_attachment :photo

  monetize :price_cents

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true, uniqueness: { case_sensitive: false }
  validates :price_cents, presence: true, numericality: { only_integer: true }
end
