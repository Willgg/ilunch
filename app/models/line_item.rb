class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true
  validates :order_id, presence: true
  validates :product_id, presence: true, uniqueness: { scope: :order_id,
    message: "should be created once per order" }
end
