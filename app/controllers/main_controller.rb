class MainController < ApplicationController

  def index
    @events = FindEvents.new.upcoming_events.load_async
    @latest_events = FindEvents.new.latest_events.load_async
    @latest_tickets = FindEvents.new.latest_tickets.load_async
  end

end
