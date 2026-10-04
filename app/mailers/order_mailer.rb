class OrderMailer < ApplicationMailer
  default from: "Stans Book Store <stansbookstore1@gmail.com>"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.recieved.subject
  #
  def received(order)
    @order = order
    mail to: order.email, subject: "stan's online book store order confirmation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.shipped.subject
  #
  def shipped(order)
    @order = order
    mail to: order.email, subject: "stan's online book store order shipped"
  end
end
