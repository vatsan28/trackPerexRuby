class User < ApplicationRecord
  validates :user_id, presence: true
  has_many :expenses
end
