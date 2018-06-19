class Api::PaymentsController < Api::BaseController
  def order
    if Payment.where(user: current_user, payment_type: 1, status: Payment::UNVERIFIED).count>0
      return(render json: {code: 1, msg: '您已经有一笔待审核'})
    end
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

  def history
  end

  def cancel
    @payment=Payment.find(params[:id])
    if @payment.status != 0
      render json: {code: 1, msg: '订单已审核，不可撤销'}
    else
      @payment.status = 3
      @payment.save
      render json: {code: 0, msg: '撤销成功'}
    end
    return
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
      if Payment.find_by(user: current_user, payment_type: 0 ,status: Payment::UNVERIFIED)
        return(render json: {code: 1, msg: '您已经有一笔待审核'})
      end
    end

    @payment = Payment.new(payment_params)
    @payment.payment_type=0
    @payment.user=current_user
    @payment.status=0

    if @payment.balance<50
      render json: {code: 1, msg: '单次提现金额不能少于50'}
      return
    elsif @payment.balance > 100000
      render json: {code: 1, msg: '金额不能超过100000'}
      return
    elsif @payment.balance > current_user.points
      render json: {code: 1, msg: '提现金额不能大于余额'}
      return
    end
    user=current_user
    user.points-=@payment.balance
    if @payment.save
      user.save
      render json: {code: 0, msg: '成功'}
      return
    else
      render json:{code:1,msg:'错误'}
      return
    end
  end

  #反点提现
  def rebate
    return(render json: {code: 1, msg: '代理系统升级中'})

    if Payment.find_by(user: current_user, payment_type: 0) != nil
      if Payment.find_by(user: current_user, payment_type: 0 ,status: Payment::UNVERIFIED)
        return(render json: {code: 1, msg: '您已经有一笔待审核'})
      end
    end

    @payment = Payment.new(payment_params)
    @payment.payment_type=0
    @payment.user=current_user
    @payment.status=0

    if @payment.balance<50
      render json: {code: 1, msg: '单次提现金额不能少于50'}
      return
    elsif @payment.balance > 100000
      render json: {code: 1, msg: '金额不能超过100000'}
      return
    elsif @payment.balance > (current_user.sum_journal.to_f - current_user.rebate)
      render json: {code: 1, msg: '提现金额不能大于反点'}
      return
    end
    user=current_user
    user.rebate+=@payment.balance
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