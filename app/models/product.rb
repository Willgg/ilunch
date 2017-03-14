class Product < ApplicationRecord
  CATEGORIES = ['main', 'dessert', 'drink']
  has_many :line_items
  has_many :orders, through: :line_items
  has_attachment :photo

  monetize :price_cents

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true, uniqueness: { case_sensitive: false }
  validates :price_cents, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :date, :stock, presence: true
  validates :category, presence: true, inclusion: {in: CATEGORIES}

  scope :in_stock, -> { where('stock > 0') }
  scope :of_the_day, -> { where('date = ?', Date.today) }
  scope :of_the_week, -> { where('date > ?', 7.days.ago) }
end
