class OrderMailer < ApplicationMailer

  # To test this mailer view:
  # http://localhost:3000/rails/mailers/order_mailer/confirmation

  def confirmation(order)
    @order = order
    @user = @order.user

    mail(to: @order.user.email, subject: 'Notre chef s’occupe de votre repas !')
  end
end
