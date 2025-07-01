class MoviePolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    return false unless @user

    @user.admin? || @record.author == @user
  end

  def destroy?
    return false unless @user

    @user.admin? || @record.author == @user
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
