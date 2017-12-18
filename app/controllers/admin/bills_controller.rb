class Admin::BillsController < Admin::BaseController
  def not_pay
    conditions={first_verify: 'verifypass',basic_verify: 'verifypass',customer_verify: 'verifypass',car_verify: 'verifypass',has_pay: false}
    @loans=Loan.where(conditions).page(params[:page]).per(10)
  end

  def pay
    loan=Loan.find(params[:id])

    respond_to do |format|
      if loan.pay
        format.html { redirect_to not_pay_admin_bills_path, notice: 'unlock successfully.' }
      else
        format.html { redirect_to not_pay_admin_bills_path, notice: 'unlock faild.' }
      end
    end
  end

  def has_pay

  end

  def instalment

  end
end