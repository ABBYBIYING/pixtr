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
    @group = Group.find(params[:id])
    @images = @group.images.includes(:gallery)
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    flash[:notice] = "left group."

    redirect_to groups_path
  end

private

  def group_params
    params.require(:group).permit(
      :name,
      :description
    )
  end
end
