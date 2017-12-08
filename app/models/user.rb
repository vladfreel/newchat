# user
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :lockable,
         :confirmable, :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable, omniauth_providers: [:twitter]
  # attr_accessor :cached_failed_attempts
  has_many :comments, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :subs
  has_many :categories_owner, class_name: 'Category', foreign_key: :user_id, dependent: :destroy
  has_many :categories, through: :subs, dependent: :destroy
  accepts_nested_attributes_for :categories, allow_destroy: true

  mount_uploader :avatar, AvatarUploader

  validates :email, presence: true
  validates :encrypted_password, presence: true, length: { minimum: 6 }


  def to_s
    self.email
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.skip_confirmation!
      user.email = auth.info.nickname + "@twitter.com"
      user.login = auth.info.nickname
      user.avatar = auth.info.image
      user.password = Devise.friendly_token[0,20]
      user.provider = auth.provider
      user.uid = auth.uid
      user.save
    end
  end

  def self.new_with_session(params,session)
    if session['devise.user_attributes']
      new(session['devise.user_attributes']) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def self.logins_before_captcha
    2
  end
end

