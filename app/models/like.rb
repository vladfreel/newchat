# like
class Like < ApplicationRecord
  belongs_to :image
  belongs_to :user
  validates :user, uniqueness: { scope: :image }
end
