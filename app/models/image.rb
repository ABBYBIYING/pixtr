class Image < ActiveRecord::Base
  belongs_to :gallery
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :users, through: :likes
  has_and_belongs_to_many :groups
  has_many :likes

  acts_as_taggable

  validates :name, presence: true
  validates :description, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true

  def self.by_most_recent
    order(created_at: :desc)
  end
end
