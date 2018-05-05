class Admin::LoansController < Admin::BaseController

  before_action :set_loan, only: [:show, :edit, :update, :destroy ,:instalment]

  def index
    if !current_user.have_power('luru')
      redirect_to power_admin_dashboard_index_path
    end

    conditions={}

    current_user.id!=1 &&
        conditions.merge!({user:current_user})

    start_date = '2016-01-01'
    end_date = DateTime.now

    params[:starttime].present? &&
        start_date = params[:starttime].to_datetime.beginning_of_day

    params[:endtime].present? &&
        end_date = params[:endtime].to_datetime.end_of_day


    params[:name].present? &&
        conditions.merge!({name:params[:name]})
    params[:first].present? &&
        conditions.merge!({first_verify:params[:first]})
    params[:review].present? &&
        conditions.merge!({review_verify:params[:review]})
    params[:pay_verify].present? &&
        conditions.merge!({pay_verify:params[:pay_verify]})

    conditions.merge!({created_at: start_date..end_date})



    if params[:export].present?
      @loans=Loan.where(conditions).order(created_at: :desc)
    else
      @loans=Loan.where(conditions).order(created_at: :desc).page(params[:page]).per(10)
    end

    if params[:export].present?
      data = CSV.generate(headers: true) do |csv|
        csv << ['合同编号', '地区', '合同金额', '借款人姓名', '手机号', '担保方式','贷款形式','还款方式','贷款利率', '贷款期限', '期限单位', '结息日', '开始时间', '结束时间']

        for i in 0..@loans.length-1
          ele = @loans[i]
          csv << [ele.basic_message.hkzl, ele.get_location, ele.basic_message.zjkje, ele.name, ele.phone,
                  ele.basic_message.dbfs, ele.basic_message.dkxs,ele.basic_message.hkfs, ele.get_lx, ele.basic_message.dkqx,
                  ele.basic_message.dkqxdw, (ele.instalments[0].present? ? (ele.instalments[0].overdue_time-1.days).strftime("%d") : ''),
                  (ele.basic_message.ksrq.present? ? ele.basic_message.ksrq.strftime("%Y-%m-%d") : ''),(ele.basic_message.jsrq.present? ? ele.basic_message.jsrq.strftime("%Y-%m-%d") : '')]
        end
      end
      send_data data, filename: "订单列表-#{Date.today}.csv"
    end
  end

  def totle_loan
    if !current_user.have_power('totle_loan')
      redirect_to power_admin_dashboard_index_path
    end
    conditions={location:current_user.get_locations}
    @loans=Loan.where(conditions).page(params[:page]).per(10)
  end

  def show
    if !current_user.have_power('luru')
      redirect_to power_admin_dashboard_index_path
    end

    @message=@loan.loan_message || LoanMessage.new()
  end

  def new
    if !current_user.have_power('luru')
      redirect_to power_admin_dashboard_index_path
    end
    @loan=Loan.new
  end

  def edit

  end

  def update
    respond_to do |format|
      if @loan.update(loan_params)
        @message=@loan.loan_message || LoanMessage.new(loan:@loan)
        @message.update(params.require(:message).permit!)
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

  def review
    if request.post?
      @loan=Loan.find(params[:loan][:id])
      respond_to do |format|
        if @loan.update(loan_params)
          format.html {
            redirect_to admin_loan_path(@loan), notice: '添加成功'
          }
        else
          format.html {
            render :new
          }
        end
      end
    end
  end

  def financial_verify
    @loan=Loan.find(params[:id])
    #标记审过
    @loan.pay_verify=Loan::UNVERIFIED
    @loan.save
    respond_to do |format|
      format.html {redirect_to admin_loans_path, notice: '添加成功'}
      format.json {render :show, status: :ok, location: @loan}
    end
  end

  def instalment
    @instalments=@loan.get_instalment
    render :instalment ,layout: false
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_loan
    @loan = Loan.find(params[:id])
  end
  def loan_params
    params.require(:loan).permit!
  end
end