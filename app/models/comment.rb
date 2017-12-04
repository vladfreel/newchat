# comment
class Comment < ApplicationRecord
  belongs_to :image
  belongs_to :user

  def to_s
    self.id
  end
end
