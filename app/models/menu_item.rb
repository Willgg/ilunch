class MenuItem < ApplicationRecord
  belongs_to :product
  belongs_to :line_item

  validates :quantity, presence: true, numericality: { only_integer: true }
  validates :line_item, presence: true
  validates :product_id, presence: true
  validate :match_menu_inventory

  def match_menu_inventory
    missings = line_item.missing_menu_items
    if ( !missings.key?(product.category.to_sym) || ( missings[product.category.to_sym] - quantity < 0 ) )
      errors.add(:product, "too many product of this type for this menu")
    end
  end
end
