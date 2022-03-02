# frozen_string_literal: true

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
    user
  end

  def new?
    user.software_quality_assurance?
  end

  def create?
    new?
  end

  def edit?
    (user.manager? && bug.project.user_id == user.id) || user.developer? || bug.assigned_to_id == user.id
  end

  def update?
    edit?
  end

  def destroy?
    user.manager? || user.software_quality_assurance?
  end

  # def include_user
  #   bug.project.users.include? user
  # end

  # class Scope < Scope
  # end
end
