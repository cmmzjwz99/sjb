class Admin::PaymentsController < Admin::BaseController

  def index
    conditions = {}

    params[:login].present? &&
        conditions.merge!({user_id: params[:login]})
    params[:status].present? &&
        conditions.merge!({status: params[:status]})
    params[:date].present? &&
        conditions.merge!({created_at:DateTime.parse(params[:date]).all_day})
    @payments = Payment.where(conditions).page(params[:page]).per(10)
  end

  def sh_fail
    @payment = Payment.find(params[:id])
    @payment.status=2
    @payment.save
    respond_to do |format|
      format.html { redirect_to admin_payments_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sh_success
    @payment = Payment.find(params[:id])
    @payment.status=1
    @payment.pay if @payment.payment_type==true
    @payment.save
    respond_to do |format|
      format.html { redirect_to admin_payments_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to admin_payments_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

end