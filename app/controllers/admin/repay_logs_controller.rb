class Admin::RepayLogsController < Admin::BaseController

  before_action :set_logs, only: [:show, :edit, :update, :destroy]
  def index
    if !current_user.have_power('caiwu')
      redirect_to power_admin_dashboard_index_path
    end

    @repaylogs=RepayLog.where(status:Loan::UNVERIFIED).page(params[:page]).per(10)
  end
  def update
    RepayLog.transaction do
      respond_to do |format|
        if @repaylog.status==Loan::UNVERIFIED
          @repaylog.update(repay_params)
          if @repaylog.status==Loan::VERIFYPASS
            instalment=@repaylog.instalment
            instalment.has_repay=true
            instalment.save
          end
          @repaylog.verify_user_id=current_user.id
          @repaylog.verify_time=Time.now
          @repaylog.save
          format.html {redirect_to admin_repay_logs_path, notice: 'successfully updated'}
          format.json {render :show, status: :ok, location: @repaylog}
        else
          format.html {render :edit}
          format.json { render json: @repaylog.errors, status: :unprocessable_entity }
        end
      end
    end
  end
  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_logs
    @repaylog = RepayLog.find(params[:id])
  end
  def repay_params
    params.require(:repaylog).permit!
  end
end