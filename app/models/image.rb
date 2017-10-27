class Image < ApplicationRecord
  has_many :comments
  belongs_to :category

  def upd
    increment!(likes)

  end
end
