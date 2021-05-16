class PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    (not record.draft?) || author? || admin?
  end

  def create?
    true
  end

  def update?
    author? || admin?
  end

  def destroy?
    author? || admin?
  end

  def drafts?
    !!user
  end

  private
  def author?
    return false unless user

    record.author_id == user.id
  end
end