class OrderMailerPreview < ActionMailer::Preview
  def confirmation
    order = Order.last
    OrderMailer.confirmation(order)
  end
end
