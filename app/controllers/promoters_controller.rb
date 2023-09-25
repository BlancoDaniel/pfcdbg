class PromotersController < ApplicationController


  def new
    @promoter = Promoter.new

  end

  def edit
  end

  def create
    @promoter = Promoter.new(promoter_params)
    @promoter.user_id = current_user.id

    if  !Promoter.where(user_id: User.first.id).exists?
      respond_to do |format|
        if @promoter.save
          format.html { redirect_to '/', notice: "Usuario promotor creado" }
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

  def promoter_params
    params.require(:promoter).permit(:name, :cif, :address, :phone_number)
  end
end