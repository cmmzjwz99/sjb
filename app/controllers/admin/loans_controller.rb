class Admin::LoansController < Admin::BaseController

  before_action :set_loan, only: [:show, :edit, :update, :destroy]

  def index
    @loans=Loan.page(params[:page]).per(10)
  end

  def show

  end

  def new
    @loan=Loan.new
  end

  def edit

  end

  def update

  end

  def create

    @loan=Loan.new(loan_params)
    @loan.user=current_user
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

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_loan
    @loan = Loan.find(params[:id])
  end
  def loan_params
    params.require(:loan).permit(:name, :idcard,:phone,:source)
  end

end