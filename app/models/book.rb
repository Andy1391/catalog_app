class Book < ApplicationRecord
  validates :title, :author, :category, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
end
