class ClientsController < ApplicationController


  def new
    @client = Client.new

  end

  def edit
  end

  def create
    @client = Client.new(client_params)
    @client.user_id = current_user.id

    if  !Client.where(user_id: User.first.id).exists?
      respond_to do |format|
        if @client.save
          format.html { redirect_to '/', notice: "Usuario cliente creado" }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to '/', notice: "Ya tiene usuario" }
      end
    end


  end

  private

  def client_params
    params.require(:client).permit(:name,:surname, :address, :nif, :phone_number)
  end
end