# comment
class Comment < ApplicationRecord
  belongs_to :image
  belongs_to :user
  validates :com_email, presence: true
  validates :body, presence: true
end
