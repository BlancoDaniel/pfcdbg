class PromotersController < ApplicationController

  def new
    @promoter = Promoter.new

  end

  def edit
  end

  def create
    @promoter = Promoter.create(promoter_params)
    @promoter.user_id = current_user.id

    return redirect_to root_path, notice: "Ya tiene usuario"  if user_has_profile?
     if @promoter.save
       current_user.add_role :promoter
       return redirect_to root_path, notice: "Usuario promotor creado"

     end
    render :new, status: :unprocessable_entity
  end

  private

  def user_has_profile?
    Promoter.exists?(user_id: current_user.id) || Client.exists?(user_id: current_user.id)
  end

  def promoter_params
    params.require(:promoter).permit(:name, :cif, :address, :phone_number)
  end
end