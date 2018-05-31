class Agent::PaymentsController < Agent::BaseController

  def index
    conditions = {user:User.where(father_id:current_user.id)}

    params[:name].present? &&
        conditions.merge!({user: User.find_by_login(params[:name])})
    params[:payment_type].present? &&
        conditions.merge!({payment_type: params[:payment_type]})
    params[:status].present? &&
        conditions.merge!({status: params[:status]})
    params[:date].present? &&
        conditions.merge!({created_at:DateTime.parse(params[:date]).all_day})
    @payments = Payment.where(conditions).page(params[:page]).per(10)
  end

  def sh_fail
    @payment = Payment.find(params[:id])
    @payment.status=2
    @payment.pay if @payment.payment_type==false
    @payment.save
    respond_to do |format|
      format.html { redirect_to agent_payments_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sh_success
    @payment = Payment.find(params[:id])
    @payment.status=1
    @payment.pay if @payment.payment_type==true
    @payment.save
    respond_to do |format|
      format.html { redirect_to agent_payments_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to agent_payments_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

end