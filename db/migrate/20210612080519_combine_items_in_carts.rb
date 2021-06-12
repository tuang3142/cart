class CombineItemsInCarts < ActiveRecord::Migration[6.1]
  def up
    Cart.all.each do |cart|
      item_count = cart.line_items.group(:product_id).sum(:quantity)
      item_count.each do |product_id, total_quantity|
        next if total_quantity <= 1

        cart.line_items.where(product_id: product_id).destroy_all
        cart.line_items.create!(product_id: product_id, quantity: total_quantity)
      end
    end
  end

  def down
    Cart.all.each do |cart|
      cart.line_items.each do |line_item|
        quantity = line_item.quantity
        next if quantity <= 1

        quantity.times { cart.line_items.create(product: line_item.product) }
        line_item.destroy
      end
    end
  end
end
