class MenuItem < ApplicationRecord
  belongs_to :product
  belongs_to :menu

  validates :quantity, presence: true, numericality: { only_integer: true }
  validates :menu_id, presence: true
  validates :product_id, presence: true

end
