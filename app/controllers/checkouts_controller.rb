class CheckoutsController < ApplicationController
  
  def show
    return redirect_to new_user_session_path, alert: "Debe registrarse o iniciar sesión" if !current_user
    event 
    user_id = current_user.id
    @inputQuantity = params[:inputQuantity].to_i
  
    cache_key = "event_#{event.id}_user_#{user_id}"
  
    cached_data = Rails.cache.read(cache_key)

    if cached_data
      @event = cached_data[:event]
      @total = cached_data[:total]
      @inputQuantity = cached_data[:input_quantity]
      @checkout_session = cached_data[:checkout_session]
    else
      return redirect_to event_path(event), alert: "No hay tantas entradas disponibles" if @inputQuantity > event.ticket_quantity 
      return redirect_to event_path(event), alert: "Solo se permite la compra de 6 entradas" if @inputQuantity > 6

      event.update(ticket_quantity: event.ticket_quantity - @inputQuantity)
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
        success_url: "http://127.0.0.1:3000/checkout/success?id=#{event.id}&",
        cancel_url: 'http://127.0.0.1:3000/events'
      )
      session[:checkout_session_id] = @checkout_session.id
      checkout_session_id = session[:checkout_session_id]

      DestroyCheckoutSessionJob.set(wait: 1.minutes).perform_later(event, @inputQuantity, checkout_session_id)


      cached_data = { event: event, total: @total, checkout_session: @checkout_session, input_quantity: @inputQuantity}
      Rails.cache.write(cache_key, cached_data, expires_in: 1.minutes)
    end
  end

  def destroy_checkout_session
    event = Event.find(params[:id])
    input_quantity = params[:input_quantity].to_i
    checkout_session_id = session[:checkout_session_id]
    user_id = current_user.id
    
    DestroyCheckoutSessionJob.perform_now(event, input_quantity, checkout_session_id)
    redirect_to event_path(event)

    cache_key = "event_#{event.id}_user_#{user_id}"
    Rails.cache.delete(cache_key)

  end

  private

  def event
    @event = Event.find(params[:id])
  end

end