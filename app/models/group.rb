class Group < ActiveRecord::Base
  has_many :users, through: :group_memberships
  has_many :group_memberships
  has_and_belongs_to_many :images

  def add_member(user)
    users << user
  end

  def remove_member(user)
    users.delete(user)
  end
end
