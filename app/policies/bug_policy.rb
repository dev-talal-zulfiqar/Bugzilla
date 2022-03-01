class BugPolicy < ApplicationPolicy
  attr_reader :user, :bug

  def initialize(user, bug)
    super(user, bug)
    @user = user
    @bug = bug
  end

  def index?
    user.manager?
  end

  def show?
    user.manager? || user.software_quality_assurance? || bug.assigned_to_id == user.id
  end

  def create?
    user.manager? || user.software_quality_assurance?
  end

  def new?
    user.manager? || user.software_quality_assurance?
  end

  def update?
    user.manager? || bug.assigned_to_id == user.id
  end

  def edit?
    user.manager? || bug.assigned_to_id == user.id
  end

  def destroy?
    user.manager? || user.software_quality_assurance?
  end

  def include_user
    bug.project.users.include? user
  end

  class Scope < Scope
  end
end
