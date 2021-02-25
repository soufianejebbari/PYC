class CruisePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.boats.count > 0
  end

  def show?
    true
  end

  def edit?
    user == record.user
  end

  def delete?
    user == record.user
  end
end
