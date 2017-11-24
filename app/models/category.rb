# category
class Category < ApplicationRecord
  has_many :images, dependent: :destroy
  has_many :subs, dependent: :destroy
  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  has_many :users, through: :subs, dependent: :destroy
  accepts_nested_attributes_for :subs, allow_destroy: true
  validates :name, presence: true
end
