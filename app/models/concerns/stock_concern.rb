module StockConcern
  extend ActiveSupport::Concern

  included do
    action_destroy :add_product_stock, if: :order_payed?
  end

  module ClassMethods
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
end
