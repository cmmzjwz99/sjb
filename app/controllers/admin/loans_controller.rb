class Admin::LoansController < Admin::BaseController

  before_action :set_loan, only: [:show, :edit, :update, :destroy]

  def index
    #status=['verifyfail','verifypass']
    #conditions={location:current_user.get_locations,first_verify:status,customer_verify:status,car_verify:status,basic_verify:status}
    conditions={}
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

  def img_upload
    @loan=Loan.find(params[:loan_id])
    img=LoanImage.new(loan:@loan)
    img.img=params[:img]
    img.style=params[:type]
    if img.save
      render json: {code:0,data:{url:img.img.url,name:img.img.url.split('/').last,date:img.created_at.strftime('%Y-%m-%d %H:%M:%S'),id:img.id,type:img.style}}
    end
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