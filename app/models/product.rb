class Product < ApplicationRecord

  CATEGORIES = ['main', 'dessert', 'drink', 'extra']
  has_many :line_items
  has_many :menu_items
  has_many :orders, through: :line_items
  has_attachment :photo

  monetize :price_cents

  validates :name, presence: true
  validates :description, presence: true
  validates :price_cents, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :date, :stock, presence: true
  validates :category, presence: true, inclusion: {in: CATEGORIES}

  scope :in_stock, -> { where('stock > 0') }
  scope :of_the_day, ->(date) { where('date = ?', date) }
  scope :of_the_week, -> { where('date <= ? AND date >= ?', Date.today + 7.days, Date.today) }
  scope :available_for, ->(date) { of_the_day(date).in_stock }
  scope :available_between, ->(from, to) { where('date >= ? AND date <= ?', from, to) }

  scope :category, ->(cat) { where(category: cat) }

  def self.next_category(string)
    CATEGORIES[CATEGORIES.index(string) + 1]
  end

  def has_stock?
    stock > 0
  end
end
