class ClientsController < ApplicationController

  def new
    @client = Client.new

  end

  def edit
  end

  def create
    @client = Client.create(client_params)
    @client.user_id = current_user.id

    return redirect_to root_path, notice: "Ya tiene usuario"  if user_has_profile?
    if @client.save
      current_user.add_role :client
      return redirect_to root_path, notice: "Usuario cliente creado"

    end
    render :new, status: :unprocessable_entity
  end

  private

  def user_has_profile?
    Promoter.exists?(user_id: current_user.id) || Client.exists?(user_id: current_user.id)
  end
  def client_params
    params.require(:client).permit(:name,:surname, :address, :nif, :phone_number)
  end
end