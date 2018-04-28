class Admin::VerifyController < Admin::BaseController
  def first
    if !current_user.have_power('admin')
      redirect_to power_admin_dashboard_index_path
    end
    conditions ={first_verify:Loan::UNVERIFIED}


    params[:name].present? &&
        conditions.merge!({name:params[:name]})


    @loans=Loan.where(conditions).order(updated_at: :desc).page(params[:page]).per(10)
  end

  def first_verify
    if !current_user.have_power('admin')
      redirect_to power_admin_dashboard_index_path
    end
    @loan=Loan.find(params[:id])
    @message=@loan.loan_message || LoanMessage.new()
    #标记审过
    @loan.first_submit=true
    @loan.save
    if request.post?
      respond_to do |format|
        if params[:first_verify].present? && @loan.first_verify==Loan::UNVERIFIED
          @loan.first_verify=params[:first_verify]
          if @loan.first_verify==Loan::VERIFYFAIL
            LoanComment.create({loan:@loan,status:'初审',content:params[:comment],verify_user:current_user.id})
          end
          @loan.save
        end
        format.html { redirect_to first_admin_verify_index_path , notice: 'successfully updated.' }
      end
    end
  end

  def review
    if !current_user.have_power('admin')
      redirect_to power_admin_dashboard_index_path
    end
    conditions ={review_verify:Loan::UNVERIFIED}

    params[:name].present? &&
        conditions.merge!({name:params[:name]})

    @loans=Loan.where(conditions).order(updated_at: :desc).page(params[:page]).per(10)
  end

  def review_verify
    if !current_user.have_power('admin')
      redirect_to power_admin_dashboard_index_path
    end
    @loan=Loan.find(params[:id])
    @message=@loan.loan_message || LoanMessage.new()
    #标记审过
    @loan.review_submit=true
    @loan.save
    if request.post?
      respond_to do |format|
        if params[:review_verify].present? && @loan.review_verify==Loan::UNVERIFIED
          @loan.review_verify=params[:review_verify]
          if @loan.review_verify==Loan::VERIFYFAIL
            LoanComment.create({loan:@loan,status:'复审',content:params[:comment],verify_user:current_user.id})
          end
          @loan.save
        end
        format.html { redirect_to review_admin_verify_index_path , notice: 'successfully updated.' }
      end
    end
  end


  def financial
    if !current_user.have_power('caiwushenhe')
      redirect_to power_admin_dashboard_index_path
    end
    conditions ={pay_verify:Loan::UNVERIFIED}

    start_date = '2016-01-01'
    end_date = DateTime.now

    params[:starttime].present? &&
        start_date = params[:starttime].to_datetime.beginning_of_day

    params[:endtime].present? &&
        end_date = params[:endtime].to_datetime.end_of_day

    conditions.merge!({created_at:start_date..end_date})

    @loans=Loan.where(conditions).order(updated_at: :desc).page(params[:page]).per(10)
  end

  def financial_verify
    if !current_user.have_power('caiwushenhe')
      redirect_to power_admin_dashboard_index_path
    end
    @loan=Loan.find(params[:id])
    @message=@loan.loan_message || LoanMessage.new()
    if request.post?
      respond_to do |format|
        if params[:pay_verify].present? && @loan.pay_verify==Loan::UNVERIFIED
          @loan.pay_verify=params[:pay_verify]
          @loan.save
        end
        format.html { redirect_to financial_admin_verify_index_path , notice: 'successfully updated.' }
      end
    end
  end

end