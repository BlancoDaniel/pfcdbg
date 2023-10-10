class FindEvents
  attr_reader :events

  def initialize(events = initial_scope)
    @events = events
  end

  def call (params = {})
    scoped = events
    scoped = filter_by_category_id(scoped, params[:category_id])

  end

  private

  def initial_scope
    Event.with_attached_poster
  end

  def filter_by_category_id(scoped, category_id)
    return scoped unless category_id.present?

    scoped.where(category_id: category_id)
  end
end