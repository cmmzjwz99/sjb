class Admin::VerifyController < Admin::BaseController
  def first
    conditions ={first_verify:Loan::UNVERIFIED}
    @loans=Loan.where(conditions).page(params[:page]).per(10)
  end

  def first_verify
    @loan=Loan.find(params[:id])
    if request.post?
      respond_to do |format|
        if params[:first_verify].present? && @loan.first_verify==Loan::UNVERIFIED
          @loan.first_verify=params[:first_verify]
          if @loan.first_verify==Loan::VERIFYPASS
            basic=@loan.basic_message || BasicMessage.new(loan:@loan)
            basic.save
          end
          @loan.save
        end
        format.html { redirect_to first_admin_verify_index_path , notice: 'successfully updated.' }
      end
    end
  end
  def basic
    conditions ={status:Loan::UNVERIFIED}
    @basics=BasicMessage.where(conditions).page(params[:page]).per(10)
  end

  def basic_verify
    @basic=BasicMessage.find(params[:id])
    @loan=@basic.loan
    if request.post?
      respond_to do |format|
        if params[:basic][:status].present? && @basic.status==Loan::UNVERIFIED
          @basic.status=params[:basic][:status]
          @basic.save
        end
        format.html { redirect_to basic_admin_verify_index_path , notice: 'successfully updated.' }
      end
    end
  end


  def customer
    conditions ={status:Loan::UNVERIFIED}
    @customers=CustomerMessage.where(conditions).page(params[:page]).per(10)
  end

  def customer_verify
    @customer=CustomerMessage.find(params[:id])
    @loan=@customer.loan
    @basic=@loan.basic_message
    if request.post?
      respond_to do |format|
        if params[:customer][:status].present? && @customer.status==Loan::UNVERIFIED
          @customer.status=params[:customer][:status]
          @customer.save
        end
        format.html { redirect_to customer_admin_verify_index_path , notice: 'successfully updated.' }
      end
    end
  end

  def car
    conditions ={status:Loan::UNVERIFIED}
    @cars=CarMessage.where(conditions).page(params[:page]).per(10)
  end

  def car_verify
    @car=CarMessage.find(params[:id])
    @loan=@car.loan
    @basic=@loan.basic_message
    if request.post?
      respond_to do |format|
        if params[:car][:status].present? && @car.status==Loan::UNVERIFIED
          @car.status=params[:car][:status]
          @car.save
        end
        format.html { redirect_to customer_admin_verify_index_path , notice: 'successfully updated.' }
      end
    end
  end
end