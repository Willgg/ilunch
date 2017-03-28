class Product < ApplicationRecord
  CATEGORIES = ['main', 'dessert', 'drink', 'extra']
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
  scope :of_the_day, ->(date) { where('date = ?', date) }
  scope :of_the_week, -> { where('date <= ? AND date >= ?', Date.today + 7.days, Date.today) }
  scope :available_for, ->(date) { of_the_day(date).in_stock }

  scope :category, ->(cat) { where(category: cat) }

  def self.next_category(string)
    CATEGORIES[CATEGORIES.index(string) + 1]
  end
end
