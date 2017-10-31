class Image < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :category

  def upd
    increment!(likes)

  end
end
