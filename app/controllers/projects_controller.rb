# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :permit_params, only: [:create]
  before_action :find_and_authorize_project, only: %i[update show destroy]

  def index
    @projects = policy_scope(Project)
  end

  def new
    @project = Project.new
    authorize @project, :new?
    @user = User.where(role: %w[developer software_quality_assurance])
  end

  def create
    @project = Project.new(permit_params)
    authorize @project, :create?
    @project.user_id = current_user.id
    @project.save
    if @project.projects_users.create(user_id: permit_params[:user_id])
      flash[:notice] = 'Project created!'
    else
      flash[:error] = 'Something Went Wrong!'
    end
    redirect_to root_path
  end

  def edit
    id = params.require(:id)
    @project = Project.find(id)
    authorize @project, :edit?
    @user = User.all
  end

  def update
    find_and_authorize_project
    if @project.projects_users.update(user_id: permit_params[:user_id])
      flash[:notice] = 'Project updated!'
      redirect_to root_path
    else
      render action: :edit
    end
  end

  def show
    find_and_authorize_project
    @user = @project.users
  end

  def destroy
    find_and_authorize_project
    if @project.destroy
      flash[:notice] = 'Project deleted!'
      redirect_to root_path
    else
      flash[:notice] = 'something went wrong!'
    end
  end

  private

  def find_and_authorize_project
    @project = Project.find(params[:id])
    authorize @project
  end

  def permit_params
    params.require(:project).permit(:title, :description, :project_members, :user_id)
  end
end
