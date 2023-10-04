class EventPolicy < ApplicationPolicy
  attr_reader :user, :event

  def initialize(user, event)
    @user = user
    @event = event
  end

  def create?
    user&.has_role? :promoter
  end

  def new?
    create?
  end

  def update?
    create? && user.promoter&.id == event.promoter_id
  end

  def edit?
    update?
  end

  def destroy?
    create? && user.promoter&.id == event.promoter_id
  end

end