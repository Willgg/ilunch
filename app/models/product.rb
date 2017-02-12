class Product < ApplicationRecord
  has_many :line_items
  has_many :orders, through: :line_items
  has_attachment :photo

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true, uniqueness: { case_sensitive: false }
end
