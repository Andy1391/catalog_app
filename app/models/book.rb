class Book < ApplicationRecord
  belongs_to :author
  has_one :categories
  has_many :order_items
  has_many :orders, :through => :order_items
  validates :title, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
end
