class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    (not record.draft?) || author?
  end

  def create?
    true
  end

  def update?
    author?
  end

  def destroy?
    author?
  end

  private
  def author?
    return false unless user

    record.author_id == user.id
  end
end