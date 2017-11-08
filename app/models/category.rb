class Category < ApplicationRecord
  has_many :images, dependent: :destroy
  has_many :subs
  accepts_nested_attributes_for :subs, allow_destroy: true
  validates :name, presence: true
end
