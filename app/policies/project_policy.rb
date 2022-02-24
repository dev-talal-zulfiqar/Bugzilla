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
    user.manager? || user.software_quality_assurance? || include_user
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
    user.manager? && project.created_by == user
  end

  def destroy?
    user.manager? && project.created_by == user
  end

  def include_user
    project.users.include? user
  end
  class Scope < Scope
    def resolve
      if user.developer?
        scope.joins(:users).where users: { id: user.id }
      else
        scope.all
      end
    end
  end
end
