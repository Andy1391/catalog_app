class OrderItem < ApplicationRecord  
  belongs_to :book
  belongs_to :order
  
  def total_price
    book.price * quantity
  end
end
