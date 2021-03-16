class Category < ApplicationRecord
  belongs_to :book, optional: true

  validates :name, presence: true
end
