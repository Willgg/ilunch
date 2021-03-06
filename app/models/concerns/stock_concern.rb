module StockConcern
  extend ActiveSupport::Concern

  included do
    after_destroy :add_product_stock, if: :order_payed?
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
