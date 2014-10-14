class GroupMembershipsController < ApplicationController
  def create
   @group = Group.find(params[:id])
   @group.add_member(current_user)
   flash[:notice] = "joined group!"

   redirect_to @group
  end

  def destroy
   @group = Group.find(params[:id])
   @group.remove_member(current_user)

   redirect_to @group
  end
end
