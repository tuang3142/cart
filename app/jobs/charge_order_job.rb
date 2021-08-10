class ChargeOrderJob < ApplicationJob
  queue_as :default

  def perform(order, payment_method_params)
    order.charge!(payment_method_params)
  end
end
