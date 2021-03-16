class AddBookToOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :order_items, :book, null: false, foreign_key: true
  end
end
