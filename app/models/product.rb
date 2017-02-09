class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true, uniqueness: { case_sensitive: false }

  has_many :line_items
  has_many :orders, through: :line_items
  has_attachment :photo
end
