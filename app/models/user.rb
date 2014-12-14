class User < ActiveRecord::Base
  has_many :comments
  has_many :images
  has_many :galleries
  has_many :group_memberships, dependent: :destroy
  has_many :groups, through: :group_memberships
  has_many :likes
  has_many :liked_images, through: :likes, source: :image

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  def join(group)
    group.user << self
  end
end
