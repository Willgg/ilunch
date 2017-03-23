class Menu < ApplicationRecord
  has_many :line_items
  has_many :menu_items
  has_many :orders, through: :line_items
  has_many :products, through: :menu_items
  has_attachment :photo

  monetize :price_cents

  validates :title, presence: true

  def full?
    selected_products == components
  end

  def missing_menu_items
    list = Hash.new
    components.each_pair do |k, v|
      list[k] =
        selected_products.key?(k) ? v - selected_products[k] : v
    end
    return list.reject { |k, v| v <= 0 }
  end

  def next_step
    missing_menu_items.keys.first
  end

  def selected_products
    inventory = {}
    menu_items.each do |mi|
      if inventory.key?(mi.product.category)
        inventory[mi.product.category.to_sym] += + 1
      else
        inventory[mi.product.category.to_sym] = mi.quantity
      end
    end
    return inventory
  end

  def components
    { main: main, dessert: dessert, drink: drink }
  end

end
