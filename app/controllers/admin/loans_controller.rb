class Admin::LoansController < Admin::BaseController

  before_action :set_loan, only: [:show, :edit, :update, :destroy]

  def index
    if !current_user.have_power('input')
      redirect_to power_admin_dashboard_index_path
    end
    conditions={user:current_user}

    start_date = '2016-01-01'
    end_date = DateTime.now

    params[:starttime].present? &&
        start_date = params[:starttime].to_datetime.beginning_of_day

    params[:endtime].present? &&
        end_date = params[:endtime].to_datetime.end_of_day

    conditions.merge!({created_at: start_date..end_date})

    @loans=Loan.where(conditions).order(created_at: :desc).page(params[:page]).per(10)
  end

  def totle_loan
    if !current_user.have_power('totle_loan')
      redirect_to power_admin_dashboard_index_path
    end
    conditions={location:current_user.get_locations}
    @loans=Loan.where(conditions).page(params[:page]).per(10)
  end

  def show
    @car=@loan.car_message || CarMessage.new
    @customer=@loan.customer_message || CustomerMessage.new
    @basic=@loan.basic_message || CustomerMessage.new
  end

  def new
    @loan=Loan.new
  end

  def edit

  end

  def update
    respond_to do |format|
      if @loan.update(loan_params)
        format.html {redirect_to admin_loans_path, notice: 'successfully updated'}
        format.json {render :show, status: :ok, location: @loan}
      else
        format.html {render :edit}
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @loan= Loan.new(loan_params)
    @loan.user=current_user
    @loan.location=current_user.location
    respond_to do |format|
      if @loan.save
        format.html {
          redirect_to admin_loans_url, notice: '添加成功'
        }
      else
        format.html {
          render :new
        }
      end
    end
  end

  def destroy

  end

  def car
    if request.post?
      @car= CarMessage.find_by_loan_id(params[:car][:loan_id]) || CarMessage.new
      respond_to do |format|
        if @car.update(car_params)
          format.html {
            redirect_to admin_loan_path(@car.loan), notice: '添加成功'
          }
        else
          format.html {
            render :new
          }
        end
      end
    end
  end

  def customer
    if request.post?
      @customer= CustomerMessage.find_by_loan_id(params[:customer][:loan_id]) || CustomerMessage.new
      respond_to do |format|
        if @customer.update(customer_params)
          format.html {
            redirect_to admin_loan_path(@customer.loan), notice: '添加成功'
          }
        else
          format.html {
            render :new
          }
        end
      end
    end
  end

  def basic
    if request.post?
      @basic= BasicMessage.find_by_loan_id(params[:basic][:loan_id]) || BasicMessage.new
      BasicMessage.transaction do
        respond_to do |format|
          if @basic.update(basic_params)
            format.html {
              redirect_to admin_loan_path(@basic.loan), notice: '添加成功'
            }
          else
            format.html {
              render :new
            }
          end
        end
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_loan
    @loan = Loan.find(params[:id])
  end
  def loan_params
    params.require(:loan).permit(:name, :idcard,:phone,:source,:first_verify)
  end
  def car_params
    params.require(:car).permit!
  end
  def customer_params
    params.require(:customer).permit!
  end
  def basic_params
    params.require(:basic).permit!
  end
end