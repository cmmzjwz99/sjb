class Admin::BillsController < Admin::BaseController
  def not_pay
    if !current_user.have_power('financial')
      redirect_to power_admin_dashboard_index_path
    end
    conditions={location:current_user.get_locations,first_verify: 'verifypass',basic_verify: 'verifypass',customer_verify: 'verifypass',car_verify: 'verifypass',has_pay: false}
    @loans=Loan.where(conditions).page(params[:page]).per(10)
  end

  def pay
    if !current_user.have_power('financial')
      redirect_to power_admin_dashboard_index_path
    end
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
    if !current_user.have_power('financial')
      redirect_to power_admin_dashboard_index_path
    end
    conditions={location:current_user.get_locations,first_verify: 'verifypass',basic_verify: 'verifypass',customer_verify: 'verifypass',car_verify: 'verifypass',has_pay: true}
    @loans=Loan.where(conditions).page(params[:page]).per(10)
  end

  def instalment
    if !current_user.have_power('financial')
      redirect_to power_admin_dashboard_index_path
    end

    @loan=Loan.find(params[:id])
  end

  def repay

    if !current_user.have_power('financial')
      redirect_to redirect_back(fallback_location: root_path)
    end

    instalment=Instalment.find(params[:id])


    instalment.has_repay=true
    respond_to do |format|
      if instalment.save
        format.html { redirect_back(fallback_location: root_path) }
      else
        format.html { redirect_back(fallback_location: root_path) }
      end
    end
  end
end