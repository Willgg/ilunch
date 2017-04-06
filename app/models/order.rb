class Order < ApplicationRecord
  enum status: [ :pending, :payed, :ready, :delivered, :failed, :canceled ]
  after_initialize :set_status

  belongs_to :user
  has_many :line_items, dependent: :destroy
  has_many :menu_items, through: :line_items
  has_many :menus, through: :line_items
  has_many :products, through: :line_items

  validates :status, inclusion: { in: statuses }

  scope :future, -> { where('created_at >= ?', Date.today) }

  def set_status
    self.status = 0 if self.status.nil?
  end

  def subtotal
    total_price / (1 + 0.2)
  end

  def vat
    total_price - subtotal
  end

  def total_price
    line_items.sum(&:total_price)
  end

  def total_price_cents
    (total_price * 100).to_i
  end

  def substract_products_stocks
    line_items.each do |li|
      li.sub_product_stock if li.product.present?
      li.menu_items.each { |mi| mi.sub_product_stock } if li.menu.present?
    end
  end

  def full?
    line_items_menu = line_items.select { |li| li.is_a_menu? }
    line_items_menu.all? { |li| li.full? }
  end

  def send_confirmation_email
    OrderMailer.confirmation(self).deliver_now
  end
end
