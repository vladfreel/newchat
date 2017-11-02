class Image < ApplicationRecord
  attr_accessor :img
  mount_uploader :img, ImgUploader
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :category
  def upd
    increment!(likes)

  end
end
