class MenuItem < ApplicationRecord
  belongs_to :product
  belongs_to :line_item

  validates :quantity, presence: true, numericality: { only_integer: true }
  validates :line_item, presence: true
  validates :product_id, presence: true
  validate :match_menu_inventory

  after_destroy :add_product_stock, if: :order_payed?

  def match_menu_inventory
    missings = line_item.missing_menu_items
    if ( !missings.key?(product.category.to_sym) || ( missings[product.category.to_sym] - quantity < 0 ) )
      errors.add(:product, "too many product of this type for this menu")
    end
  end

  def order
    line_item.order.present? ? self.line_item.order : nil
  end

  def order_payed?
    order.payed?
  end

  def add_product_stock
    self.product.update(stock: product.stock + quantity) unless self.product.nil?
  end

  def sub_product_stock
    self.product.update(stock: product.stock - quantity) unless self.product.nil?
  end
end
