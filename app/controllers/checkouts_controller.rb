class CheckoutsController < ApplicationController
  
  def show
    return redirect_to new_user_session_path, alert: "Debe registrarse o iniciar sesión" unless current_user
    event 
    user = current_user
    input_quantity = params[:inputQuantity].to_i
  
    ticket_purchase_service = TicketPurchaseService.new(user, event, input_quantity, session)
    result = ticket_purchase_service.purchase_ticket
  
    if result[:success]
      @event = result[:data][:event]
      @total = result[:data][:total]
      @inputQuantity = result[:data][:input_quantity]
      @checkout_session = result[:data][:checkout_session]
    else
      return redirect_to event_path(event), alert: result[:message]
    end
  end

  def destroy_checkout_session
    user = current_user
    event = Event.find(params[:id])
    input_quantity = params[:input_quantity].to_i
    ticket_purchase_service = TicketPurchaseService.new(user, event, input_quantity, session)
    ticket_purchase_service.destroy_checkout_session
  
    redirect_to event_path(event)
  end
  

  private

  def event
    @event = Event.find(params[:id])
  end

end