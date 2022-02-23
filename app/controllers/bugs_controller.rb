# frozen_string_literal: true

# Bugs controller
class BugsController < ApplicationController
  def index
    @bugs = Bug.where(project_id:[params[:project_id]])
  end

  def new
    @project = Project.find(params[:project_id])
    @bug = Bug.new
    @user = User.where(role: ['developer','software_quality_assurance'])
  end

  def create
    @bug = Bug.new(permit_params)
    @bug.status = 'opened'
    @bug.created_by_id = current_user.id
    @bug.project_id = params[:project_id]
    @bug.save
    redirect_to ''
  end

  def edit
    id = params.require(:id)
    @bug = Bug.find(id)
    @user = User.all
  end

  def update
    @bug = Bug.find(params.require(:id))
    if @bug.update_attributes(permit_params)
      flash[:success] = 'Bug updated!'
      redirect_to ''
    else
      render action: :edit
    end
  end

  def show
    @bug = Bug.find(params[:id])
    id = @bug.created_by_id
    @created_by = User.find(id)
    assigned_id = @bug.assigned_to_id
    @assigned_to = User.find(assigned_id)
  end

  def destroy
    @bug = Bug.find(params[:id])
    @bug.destroy
    redirect_to ''
  end

  private

  def permit_params
    params.require(:bug).permit(:title, :description, :assigned_to_id, :bug_type, :status, :deadline)
  end
end
