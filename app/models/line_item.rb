class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  belongs_to :menu

  monetize :price_cents

  validates :quantity, presence: true
  validates :order_id, presence: true
  validates :product_id, uniqueness: { scope: :order_id,
            message: "should be created once per order" }, if: 'product_id.present?'
  validates :menu_id, uniqueness: { scope: :order_id,
            message: "should be created once per order" }, if: 'menu_id.present?'


  before_create :set_price

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
end
