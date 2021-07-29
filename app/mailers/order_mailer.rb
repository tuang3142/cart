class OrderMailer < ApplicationMailer
  default from: 'Sam Ruby <depot@example.com>'

  def received(order)
    @order = order

    mail to: order.email, subject: 'Pragmatic Store Order Confirmation'
  end

  def shipped
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
