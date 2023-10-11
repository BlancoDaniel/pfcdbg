class CheckoutsController < ApplicationController

  def show
    event
    current_user.set_payment_processor :stripe
    current_user.payment_processor.customer
    @inputQuantity = params[:inputQuantity].to_i
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
        success_url: "http://127.0.0.1:3000/events/#{event.id}",
        cancel_url: 'http://127.0.0.1:3000/events'
      )

  end

  private

  def event
    @event = Event.find(params[:id])
  end
end

