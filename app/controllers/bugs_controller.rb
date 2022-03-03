# frozen_string_literal: true

# Bugs controller
class BugsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_and_autherize, only: %i[edit update show destroy]
  before_action :set_project, only: %i[index new]

  def index
    authorize @project, :show?
    if @project
      @bugs = @project.bugs
    else
      flash[:alert] = 'Project not found'
    end
  end

  def new
    @bug = Bug.new
    authorize @bug, :new?
    @user = User.where(role: %w[developer software_quality_assurance])
  end

  def create
    @bug = Bug.new(permit_params)
    authorize @bug, :create?
    generate_new_bug(@bug)
    if @bug.valid?
      @bug.save!
      flash[:notice] = 'Bug Generated'
    else
      flash[:alert] = @bug.errors.full_messages
    end
    redirect_to project_bugs_path, project_id: params[:project_id]
  end

  def edit
    @user = if current_user.manager?
              User.all
            else
              [current_user]
            end
  end

  def update
    if @bug.update(permit_params)
      flash[:notice] = 'Bug updated!'
    else
      flash[:alert] = 'something went wrong!'
    end
    redirect_to root_path
  end

  def show
    @created_by = User.find_by(id: @bug&.created_by_id)
    @assigned_to = User.find_by(id: @bug&.assigned_to_id)
  end

  def destroy
    @bug.screenshot.purge if @bug.screenshot.attached?
    if @bug.destroy
      flash[:notice] = 'Bug deleted!'
    else
      flash[:alert] = 'something went wrong'
    end
    redirect_to request.referer
  end

  private

  def find_and_autherize
    @bug = Bug.find_by(id: params[:id])
    authorize @bug if @bug
  end

  def generate_new_bug(bug)
    bug.status = Bug.statuses['opened']
    bug.assigned_to_id = nil
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
