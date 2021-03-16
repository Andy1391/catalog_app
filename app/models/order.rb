class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :books, :through => :order_items

  enum status: { new: 0, confirmed: 1, cancelled: 2, delivered: 3 }, _suffix: true
  attribute :status, :integer, default: 0

  def total_price
    order_items.to_a.sum { |item| item.total_price }
  end
end
