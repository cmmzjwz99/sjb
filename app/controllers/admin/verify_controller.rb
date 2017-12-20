class Admin::VerifyController < Admin::BaseController
  def first
    if !current_user.have_power('first_verify')
      redirect_to power_admin_dashboard_index_path
    end
    conditions ={first_verify:Loan::UNVERIFIED}
    @loans=Loan.where(conditions).page(params[:page]).per(10)
  end

  def first_verify
    if !current_user.have_power('first_verify')
      redirect_to power_admin_dashboard_index_path
    end
    @loan=Loan.find(params[:id])
    if request.post?
      respond_to do |format|
        if params[:first_verify].present? && @loan.first_verify==Loan::UNVERIFIED
          @loan.first_verify=params[:first_verify]
          if @loan.first_verify==Loan::VERIFYPASS
            @loan.verify_pass(current_user)
          end
          @loan.save
        end
        format.html { redirect_to first_admin_verify_index_path , notice: 'successfully updated.' }
      end
    end
  end
  def basic
    if !current_user.have_power('online_verify')
      redirect_to power_admin_dashboard_index_path
    end
    conditions ={status:Loan::UNVERIFIED}
    @basics=BasicMessage.where(conditions).page(params[:page]).per(10)
  end

  def basic_verify
    if !current_user.have_power('online_verify')
      redirect_to power_admin_dashboard_index_path
    end
    @basic=BasicMessage.find(params[:id])
    @loan=@basic.loan
    if request.post?
      respond_to do |format|
        if params[:basic][:status].present? && @basic.status==Loan::UNVERIFIED
          @basic.status=params[:basic][:status]
          @basic.verify_pass(current_user) if @basic.status==Loan::VERIFYPASS
          @basic.save
        end
        format.html { redirect_to basic_admin_verify_index_path , notice: 'successfully updated.' }
      end
    end
  end


  def customer
    if !current_user.have_power('customer_verify')
      redirect_to power_admin_dashboard_index_path
    end
    conditions ={status:Loan::UNVERIFIED}
    @customers=CustomerMessage.where(conditions).page(params[:page]).per(10)
  end

  def customer_verify
    if !current_user.have_power('customer_verify')
      redirect_to power_admin_dashboard_index_path
    end
    @customer=CustomerMessage.find(params[:id])
    @loan=@customer.loan
    @basic=@loan.basic_message
    if request.post?
      respond_to do |format|
        if params[:customer][:status].present? && @customer.status==Loan::UNVERIFIED
          @customer.status=params[:customer][:status]
          @customer.verify_pass(current_user) if @customer.status==Loan::VERIFYPASS
          @customer.save
        end
        format.html { redirect_to customer_admin_verify_index_path , notice: 'successfully updated.' }
      end
    end
  end

  def car
    if !current_user.have_power('car_verify')
      redirect_to power_admin_dashboard_index_path
    end
    conditions ={status:Loan::UNVERIFIED}
    @cars=CarMessage.where(conditions).page(params[:page]).per(10)
  end

  def car_verify
    if !current_user.have_power('car_verify')
      redirect_to power_admin_dashboard_index_path
    end
    @car=CarMessage.find(params[:id])
    @loan=@car.loan
    @basic=@loan.basic_message
    if request.post?
      respond_to do |format|
        if params[:car][:status].present? && @car.status==Loan::UNVERIFIED
          @car.status=params[:car][:status]
          @car.verify_pass(current_user) if @car.status==Loan::VERIFYPASS
          @car.save
        end
        format.html { redirect_to car_admin_verify_index_path , notice: 'successfully updated.' }
      end
    end
  end
end