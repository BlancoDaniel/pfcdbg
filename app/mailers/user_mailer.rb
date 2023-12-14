class UserMailer < ApplicationMailer
  def registration_success_email(client)
    @client = client
    mail(to: @client.user.email, subject: 'Registro exitoso')
  end

  def promoter_registration_success_email(promoter)
    @promoter = promoter
    mail(to: @promoter.user.email, subject: 'Registro exitoso')
  end

  def order_success_email(order, client)
    @order = order
    @client = client

    mail(to: @client.user.email, subject: 'Confirmación de Pedido')
  end

end
