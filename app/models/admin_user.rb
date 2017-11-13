class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :encrypted_password, presence: true,length: { minimum: 6 }
  validates :email, presence: true
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
end
