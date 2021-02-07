class Book < ApplicationRecord
  belongs_to :author
  has_one :categories
  validates :title, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
end
