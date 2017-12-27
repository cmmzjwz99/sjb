class Admin::VerifyController < Admin::BaseController
  def first
    if !current_user.have_power('first_verify')
      redirect_to power_admin_dashboard_index_path
    end
    conditions ={first_verify:Loan::UNVERIFIED}

    start_date = '2016-01-01'
    end_date = DateTime.now

    params[:starttime].present? &&
        start_date = params[:starttime].to_datetime.beginning_of_day

    params[:endtime].present? &&
        end_date = params[:endtime].to_datetime.end_of_day

    conditions.merge!({created_at:start_date..end_date})

    @loans=Loan.where(conditions).order(updated_at: :desc).page(params[:page]).per(10)
  end

  def first_verify
    if !current_user.have_power('first_verify')
      redirect_to power_admin_dashboard_index_path
    end
    @loan=Loan.find(params[:id])
    #标记审过
    @loan.first_submit=true
    @loan.save
    if request.post?
      respond_to do |format|
        if params[:first_verify].present? && @loan.first_verify==Loan::UNVERIFIED
          @loan.first_verify=params[:first_verify]
          if @loan.first_verify==Loan::VERIFYPASS
            @loan.verify_pass(current_user)
          end
          if @loan.first_verify==Loan::VERIFYFAIL
            LoanComment.create({loan:@loan,status:'网审',content:params[:comment],verify_user:current_user.id})
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

    start_date = '2016-01-01'
    end_date = DateTime.now

    params[:starttime].present? &&
        start_date = params[:starttime].to_datetime.beginning_of_day

    params[:endtime].present? &&
        end_date = params[:endtime].to_datetime.end_of_day

    conditions.merge!({loan:(Loan.where(created_at:start_date..end_date) )})

    @basics=BasicMessage.where(conditions).order(updated_at: :desc).page(params[:page]).per(10)
  end

  def basic_verify
    if !current_user.have_power('online_verify')
      redirect_to power_admin_dashboard_index_path
    end
    @basic=BasicMessage.find(params[:id])
    @loan=@basic.loan
    #标记审过
    @loan.basic_submit=true
    @loan.save
    if request.post?
      respond_to do |format|
        if params[:basic][:status].present? && @basic.status==Loan::UNVERIFIED
          @basic.status=params[:basic][:status]
          @basic.verify_pass(current_user) if @basic.status==Loan::VERIFYPASS
          if @basic.status==Loan::VERIFYFAIL
            LoanComment.create({loan:@loan,status:'初审',content:params[:comment],verify_user:current_user.id})
          end
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

    start_date = '2016-01-01'
    end_date = DateTime.now

    params[:starttime].present? &&
        start_date = params[:starttime].to_datetime.beginning_of_day

    params[:endtime].present? &&
        end_date = params[:endtime].to_datetime.end_of_day

    conditions.merge!({loan:(Loan.where(created_at:start_date..end_date) )})

    @customers=CustomerMessage.where(conditions).order(updated_at: :desc).page(params[:page]).per(10)
  end

  def customer_verify
    if !current_user.have_power('customer_verify')
      redirect_to power_admin_dashboard_index_path
    end
    @customer=CustomerMessage.find(params[:id])
    @loan=@customer.loan
    @basic=@loan.basic_message
    #标记审过
    @loan.customer_submit=true
    @loan.save
    if request.post?
      respond_to do |format|
        if params[:customer][:status].present? && @customer.status==Loan::UNVERIFIED
          @customer.status=params[:customer][:status]
          @customer.verify_pass(current_user) if @customer.status==Loan::VERIFYPASS

          if @customer.status==Loan::VERIFYFAIL
            LoanComment.create({loan:@loan,status:'人审',content:params[:comment],verify_user:current_user.id})
          end
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

    start_date = '2016-01-01'
    end_date = DateTime.now

    params[:starttime].present? &&
        start_date = params[:starttime].to_datetime.beginning_of_day

    params[:endtime].present? &&
        end_date = params[:endtime].to_datetime.end_of_day

    conditions.merge!({loan:(Loan.where(created_at:start_date..end_date) )})

    @cars=CarMessage.where(conditions).order(updated_at: :desc).page(params[:page]).per(10)
  end

  def car_verify
    if !current_user.have_power('car_verify')
      redirect_to power_admin_dashboard_index_path
    end
    @car=CarMessage.find(params[:id])
    @loan=@car.loan
    @basic=@loan.basic_message
    #标记审过
    @loan.car_submit=true
    @loan.save
    if request.post?
      respond_to do |format|
        if params[:car][:status].present? && @car.status==Loan::UNVERIFIED
          @car.status=params[:car][:status]
          @car.verify_pass(current_user) if @car.status==Loan::VERIFYPASS

          if @car.status==Loan::VERIFYFAIL
            LoanComment.create({loan:@loan,status:'车审',content:params[:comment],verify_user:current_user.id})
          end
          @car.save
        end
        format.html { redirect_to car_admin_verify_index_path , notice: 'successfully updated.' }
      end
    end
  end
end