class Gallery < ActiveRecord::Base
  has_many :images, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  belongs_to :user
end
