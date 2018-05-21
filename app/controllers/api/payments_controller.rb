class Api::PaymentsController < Api::BaseController
  def order
    @payment= Payment.new(payment_params)
    @payment.payment_type=true
    @payment.user=current_user
    @payment.status=0

    if @payment.save
      if @payment.balance == 0
        render json: {code:1,msg:'金额不能为0'}
        return
      elsif @payment.balance > 100000
        render json: {code:1,msg:'金额不能超过100000'}
        return
      end
    else
      render json: {code:0,msg:'成功'}
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