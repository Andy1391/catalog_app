class User < ApplicationRecord
  enum role: { user: 0, admin: 1, guest: 2 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
