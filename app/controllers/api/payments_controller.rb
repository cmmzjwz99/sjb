class Api::PaymentsController < Api::BaseController
  def order
    @payment= Payment.new(payment_params)
    @payment.payment_type=true
    @payment.user=current_user
    @payment.status=0

    if @payment.balance == 0
      render json: {code: 1, msg: '金额不能为0'}
      return
    elsif @payment.balance > 100000
      render json: {code: 1, msg: '金额不能超过100000'}
      return
    end

    if @payment.save
      render json: {code: 0, data: @payment.id}
      return
    end
  end

  def info
    @payment=Payment.find(params[:id])
  end

  def get_payments
    user=current_user.father_id.present? ? User.find(current_user.father_id) : User.find(1)
    @payment=user.user_payment || UserPayment.new({alipay_status: false, wechat_status: false, bank_status: false})
  end

  def pay_way
    user=current_user.father_id.present? ? User.find(current_user.father_id) : User.find(1)
    @payment= user.user_payment || UserPayment.new({alipay_status: false, wechat_status: false, bank_status: false})
    render json: {code: 0, data: {alipay_status: @payment.alipay_status, wechat_status: @payment.wechat_status, bank_status: @payment.bank_status}}
  end

  def tixian
    if Payment.find_by(user: current_user, payment_type: 0) != nil
      if Payment.find_by(user: current_user, payment_type: 0).status == 0
        return(render json: {code: 1, msg: '您已经有一笔待审核'})
      end
    end

    @payment = Payment.new(payment_params)
    @payment.payment_type=0
    @payment.user=current_user
    @payment.status=0

    if @payment.balance == 0
      render json: {code: 1, msg: '金额不能为0'}
      return
    elsif @payment.balance > 100000
      render json: {code: 1, msg: '金额不能超过100000'}
      return
    elsif @payment.balance > current_user.points
      render json: {code: 1, msg: '提现金额不能大于余额'}
      return
    end
    user=current_user
    user-=@payment.balance
    if @payment.save
      user.save
      render json: {code: 0, msg: '成功'}
      return
    else
      render json:{code:1,msg:'错误'}
      return
    end
  end


  private
  def payment_params
    params.require(:payments).permit!
  end

end