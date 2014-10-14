class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.save
    @group.add_member(current_user)

    redirect_to group_path(@group)
  end

  def show
    @group = Group.find(params[:id])
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:notice] = "left group."

    redirect_to groups_path
  end

private

  def group_params
    params.require(:group).permit(:name, :description)
  end
end
