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

  def get_payments
    user=current_user.father_id.present? ? User.find(current_user.father_id) : User.find(1)
    @payment=user.user_payment || UserPayment.new({alipay_status:false,wechat_status:false,bank_status:false})
  end

  private
  def payment_params
    params.require(:payments).permit!
  end

end