# frozen_string_literal: true

# Description of project policy scope
class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project

  def initialize(user, project)
    super(user, project)
    @user = user
    @project = project
  end

  def index?
    user.manager?
  end

  def show?
    (user.manager? && project.user_id == user.id) || user.software_quality_assurance? || include_user
  end

  def create?
    user.manager?
  end

  def new?
    user.manager?
  end

  def update?
    user.manager? && project.created_by == user
  end

  def edit?
    update?
  end

  def destroy?
    edit?
  end

  def include_user
    project.users.include? user
  end

  class Scope < Scope
    def resolve
      if user.developer?
        scope.joins(:users).where users: { id: user.id }
      elsif user.manager?
        scope.where(user_id: user.id)
      else
        scope.all
      end
    end
  end
end
