class Admin::CarMessagesController < Admin::BaseController

  before_action :set_car, only: [ :update]


  def update
    respond_to do |format|
      if @car.update(car_params)
        if @car.status==Loan::UNVERIFIED
          format.html { redirect_to admin_loans_url, notice: 'successfully updated.' }
        else
          format.html{redirect_to first_admin_verify_index_url,notice: 'successfully updated'}
        end
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_car
    @car = CarMessage.find(params[:id])
  end
  def car_params
    params.require(:car_message).permit!
  end
end