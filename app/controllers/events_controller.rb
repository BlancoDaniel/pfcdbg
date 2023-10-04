class EventsController < ApplicationController

  def index
    @events = Event.all.load_async
  end

  def show
    event
  end

  def new
    @event = Event.new
    @categories = Category.all.order(name: :asc)
    authorize @event
  end

  def edit
    event
    @categories = Category.all.order(name: :asc)
    authorize @event
  end

  def create
    @event = Event.create(event_params)
    @event.promoter = current_user.promoter

    if @event.save
      redirect_to events_path, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end


  def update
    if event.update(event_params)
      redirect_to events_path, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    event
    authorize @event
    event.destroy
    redirect_to events_path, notice: t('.destroyed'), status: :see_other
  end

  private
  def event_params
    params.require(:event).permit(:name,:description,:price,:date,:location,:ticket_quantity,:category_id,:poster)
  end

  def event
    @event = Event.find(params[:id])
  end
end
