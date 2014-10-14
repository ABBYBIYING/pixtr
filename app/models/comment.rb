class Comment < ActiveRecord::Base
  belongs_to :image
  belongs_to :user

  validates :content, presence: true

  def self.by_most_recent
    order(created_at: :desc)
  end
end
