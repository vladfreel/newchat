# like
class Like < ApplicationRecord
  belongs_to :image
  belongs_to :user
  validates :user, uniqueness: { scope: :image }
  def to_s
    self.id
  end
end
