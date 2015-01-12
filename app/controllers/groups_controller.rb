class GroupsController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.create(group_params)
    @group.add_member(current_user)

    if @group.save
      redirect_to @group
    else
      render :new
    end
  end

  def show
    find_group
  end

  def edit
    find_group
  end

  def update
    find_group
    @group.update(group_params)

    redirect_to @group
  end

  def destroy
    group = find_group
    group.destroy
    flash[:notice] = "left group."

    redirect_to groups_path
  end

private

  def find_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(
      :name,
      :description,
      :group_image
    )
  end
end
