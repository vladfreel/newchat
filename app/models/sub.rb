# sub
class Sub < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :user, uniqueness: { scope: :category }
  def to_s
    self.id
  end
end
