class Category < ApplicationRecord
  has_many :images, dependent: :destroy
  has_many :subs, dependent: :destroy
  has_many :users, through: :subs
  accepts_nested_attributes_for :subs, allow_destroy: true
  validates :name, presence: true
end
