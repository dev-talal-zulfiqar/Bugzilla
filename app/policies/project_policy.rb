class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project

  def index?
    user.manager?
  end

  def show?
    user.manager?
  end

  def create?
    user.manager?
  end

  def new?
    user.manager?
  end

  def update?
    user.manager?
  end

  def edit?
    user.manager?
  end

  def destroy?
    user.manager?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
    def resolve
      if user.manager?
        scope.all
      else
        scope.where(published: true)
      end
    end
  end
end
