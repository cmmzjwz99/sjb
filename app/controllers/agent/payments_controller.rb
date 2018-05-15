class Agent::PaymentsController < Agent::BaseController

  def index
    conditions = {}

    params[:login].present? &&
        conditions.merge!({user_id: params[:login]})

    @payments = Payment.where(conditions).page(params[:page]).per(10)
  end

  def sh_fail
    @payment = Payment.find(params[:id])
    @payment.status=2
    @payment.save
    respond_to do |format|
      format.html { redirect_to agent_payments_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sh_success
    @payment = Payment.find(params[:id])
    @payment.status=1
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