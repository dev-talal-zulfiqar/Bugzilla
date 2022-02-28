# frozen_string_literal: true

# Bugs controller
class BugsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_and_autherize, only: %w[edit update show destroy]
  before_action :set_project, only: %w[index new]
  def index
    @project = set_project
    authorize @project, :show?
    if @project
      @bugs = @project.bugs
    else
      flash[:error] = 'Project not found'
    end
  end

  def new
    @project = set_project
    @bug = Bug.new
    authorize @bug, :new?
    @user = User.where(role: %w[developer software_quality_assurance])
  end

  def create
    @bug = Bug.new(permit_params)
    authorize @bug, :create?
    generate_new_bug(@bug)
    if @bug.save
      flash[:success] = 'Bug Generated'
    else
      flash[:error] = 'something went wrong'
    end
    redirect_to project_bugs_path, project_id: params[:project_id]
  end

  def edit
    @user = User.all
  end

  def update
    if @bug.update_attributes(permit_params)
      flash[:success] = 'Bug updated!'
      redirect_to ''
    else
      render action: :edit
    end
  end

  def show
    @created_by = User.find(@bug.created_by_id)
    assigned_id = @bug.assigned_to_id
    @assigned_to = User.find(assigned_id)
  end

  def destroy
    @bug.screenshot.purge if @bug.screenshot.attached?
    if @bug.destroy
      flash[:notice] = 'Bug deleted!'
      redirect_to request.referrer
    else
      flash[:error] = 'something went wrong'
    end
  end

  private

  def find_and_autherize
    @bug = Bug.find(params[:id])
    authorize @bug
  end

  def generate_new_bug(bug)
    bug.status = 'opened'
    bug.created_by_id = current_user.id
    bug.project_id = params[:project_id]
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def permit_params
    params.require(:bug).permit(:title, :description, :assigned_to_id, :bug_type, :status, :deadline, :screenshot)
  end
end
