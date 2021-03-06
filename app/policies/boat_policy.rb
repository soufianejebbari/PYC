class BoatPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    return true
  end

  def show?
    true
  end

  def edit?
    user.boats.count > 0
  end

  def delete?
    user == record.user
  end
end
