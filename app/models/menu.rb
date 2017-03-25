class Menu < ApplicationRecord
  has_many :line_items
  has_many :menu_items, through: :line_items
  has_many :orders, through: :line_items
  has_many :products, through: :menu_items
  has_attachment :photo

  monetize :price_cents

  validates :title, presence: true

  def components
    components = { main: main, dessert: dessert, drink: drink }
    return components.reject{ |k, v| v <= 0 }
  end

end
