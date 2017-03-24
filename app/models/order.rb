class Order < ApplicationRecord
  enum status: [ :pending, :payed, :failed, :canceled ]
  after_initialize :set_status

  belongs_to :user
  has_many :line_items, dependent: :destroy
  has_many :menu_items, through: :line_items
  has_many :menus, through: :line_items
  has_many :products, through: :line_items

  # validates :user_id, presence: true
  # validates :company_id, presence: true
  validates :status, inclusion: { in: statuses }

  def set_status
    self.status = 0 if self.status.nil?
  end

  def subtotal
    line_items.sum(&:total_price)
  end

  def vat
    subtotal * 0.2
  end

  def total_price
    subtotal
  end

  def total_price_cents
    (total_price * 100).to_i
  end
end
