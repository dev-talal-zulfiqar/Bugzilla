class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :permit_params, only: [:create]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
    if authorize @project
      @user = User.where(role: ['developer','software_quality_assurance'])
    else
      access_denied
    end
  end

  def create
    @project = Project.new(permit_params)
    authorize @project
    @project.user_id = current_user.id
    @project.save
    @project.projects_users.create(user_id: permit_params[:user_id])
    redirect_to ''
  end

  def edit
    id = params.require(:id)
    @project = Project.find(id)
    authorize @project
    @user = User.all
  end

  def update
    @project = Project.find(params.require(:id))
    authorize @project
    if @project.update_attributes(permit_params)
      flash[:success] = 'Project updated!'
      redirect_to ''
    else
      render action: :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    authorize @project
    @project.destroy
    redirect_to ''
  end

  private

  def permit_params
    params.require(:project).permit(:title, :description, :project_members, :user_id)
  end
end
