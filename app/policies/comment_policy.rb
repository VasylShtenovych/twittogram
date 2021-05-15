class CommentPolicy < ApplicationPolicy
  def destroy?
    author?
  end


  private
  def author?
    return false unless user

    record.author_id == user.id
  end
end