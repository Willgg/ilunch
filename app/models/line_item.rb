class LineItem < ApplicationRecord
  include StockConcern

  belongs_to :order
  belongs_to :product
  belongs_to :menu
  has_many :menu_items, dependent: :destroy

  monetize :price_cents

  validates :order_id, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true }
  validates :product_id, uniqueness: { scope: :order_id,
            message: "should be created once per order" }, if: 'product_id.present?'
  # validates :menu_id, uniqueness: { scope: :order_id,
  #           message: "should be created once per order" }, if: 'menu_id.present?'

  before_create :set_price

  def is_a_product?
    !product_id.nil?
  end

  def is_a_menu?
    !menu_id.nil?
  end

  def class.of_incomplete_menu
    self.all.select do |li|
      li.is_a_menu?
    end
  end

  def set_price
    if self.product_id
      self.price = product.price
    elsif self.menu_id
      self.price = menu.price
    end
  end

  def total_price
    price * quantity
  end

  def full?
    selected_products == menu.components
  end

  def missing_menu_items
    list = Hash.new
    menu.components.each_pair do |k, v|
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
        inventory[mi.product.category.to_sym] += 1
      else
        inventory[mi.product.category.to_sym] = mi.quantity
      end
    end
    return inventory
  end

  def products
    all = []
    all << product unless product.nil?
    menu_items.each { |mi| all << mi.product } unless menu_items.nil?
    return all
  end
end
