class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  monetize :price_cents

  validates :quantity, presence: true
  validates :order_id, presence: true
  validates :product_id, presence: true, uniqueness: { scope: :order_id,
    message: "should be created once per order" }

  before_create :set_price

  def set_price
    self.price = product.price
  end

  def total_price
    price * quantity
  end
end
