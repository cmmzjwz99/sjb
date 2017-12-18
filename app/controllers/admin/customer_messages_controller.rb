class Admin::CustomerMessagesController < Admin::BaseController

  before_action :set_customer, only: [ :update]


  def update
    respond_to do |format|
      if @customer.update(customer_params)
        if @customer.status==Loan::UNVERIFIED
          format.html { redirect_to admin_loans_url, notice: 'successfully updated.' }
        else
          format.html{redirect_to first_admin_verify_index_url,notice: 'successfully updated'}
        end
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: customer.errors, status: :unprocessable_entity }
      end
    end
  end


  def img_upload
    p params
    img=CustomerImage.new(customer_message:Loan.find(params[:id]).customer_message)
    img.img=params[:img]
    if img.save
      render json: {code:0,data:{url:img.img.url,name:img.img.url.split('/').last,date:img.created_at.strftime('%Y-%m-%d %H:%M:%S'),id:img.id}}
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = CustomerMessage.find(params[:id])
  end
  def customer_params
    params.require(:customer_message).permit!
  end
end