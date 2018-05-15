class Api::PaymentsController < Api::BaseController
  def order
    @payment= Payment.new(payment_params)
    @payment.payment_type=true
    @payment.user=current_user
    @payment.status=0
    if @payment.save
      render json: {code:0,msg:'成功'}
      return
    else
      render json: {code:1,msg:'失败'}
      return
    end
  end

  private
  def payment_params
    params.require(:payment).permit!
  end

end