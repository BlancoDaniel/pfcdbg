class CheckoutsController < ApplicationController

  def show
    event
    @inputQuantity = params[:inputQuantity].to_i
    return redirect_to event_path(event), alert: "No hay tantas entradas disponibles"  if @inputQuantity>event.ticket_quantity 
    return redirect_to event_path(event), alert: "Solo se permite la compra de 6 entradas"  if @inputQuantity>6

    event.update(ticket_quantity: @inputQuantity)
    current_user.set_payment_processor :stripe
    current_user.payment_processor.customer

  
    @total = @inputQuantity * event.price

    @checkout_session = current_user.payment_processor.checkout(
      mode: 'payment',
      line_items: [{
                     price_data: {
                       currency: 'eur',
                       unit_amount: (event.price * 100).to_i,
                       product_data: {
                         name: event.name,
                       },
                     },
                     quantity: @inputQuantity
                   }],
        success_url: checkout_success_url(id: event.id, qty: @inputQuantity),
        cancel_url: 'http://127.0.0.1:3000/events'
      )
       
  end

  def success

  end

  private

  def event
    @event = Event.find(params[:id])
  end



end