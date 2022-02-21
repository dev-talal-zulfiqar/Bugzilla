class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :permit_params, only: [:create]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
    @user = User.where(role: ['developer','software_quality_assurance'])

  end

  def create
    @project = Project.new(permit_params)
    @project.user_id = current_user.id
    @project.save
    @project.projects_users.create(user_id: permit_params[:user_id])
    redirect_to ''
  end

  def edit
    id = params.require(:id)
    @project = Project.find(id)
    @user = User.all
  end

  def update
    @project = Project.find(params.require(:id))
    if @project.update_attributes(permit_params)
      flash[:success] = 'Project updated!'
      redirect_to ''
    else
      render action: :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to ''
  end

  private

  def permit_params
    params.require(:project).permit(:title, :description, :project_members, :user_id)
  end
end
