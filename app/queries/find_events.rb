class FindEvents
  attr_reader :events

  def initialize(events = initial_scope)
    @events = events
  end

  def call (params = {})
    scoped = events
    scoped = filter_by_category_id(scoped, params[:category_id])

  end

  def upcoming_events(limit = 8)
    events
      .where('date >= ?', Time.now)
      .order(date: :asc)
      .limit(limit)
  end

  def latest_events(limit = 8)
    @events
      .where('date >= ?', Time.now)
      .order(created_at: :desc)
      .limit(limit)
  end

  def latest_tickets(limit = 8)
    @events
      .where('date >= ?', Time.now)
      .where('ticket_quantity > 0')
      .where('ticket_quantity < 50')
      .order(created_at: :desc)
      .limit(limit)
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