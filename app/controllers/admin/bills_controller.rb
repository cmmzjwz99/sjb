require 'csv'
class Admin::BillsController < Admin::BaseController
  def not_pay
    if !current_user.have_power('caiwu')
      redirect_to power_admin_dashboard_index_path
    end

    conditions={first_verify: 'verifypass',review_verify: 'verifypass',pay_verify: 'verifypass',has_pay: false}
    @loans=Loan.where(conditions).page(params[:page]).per(10)
  end

  def pay
    loan=Loan.find(params[:id])

    respond_to do |format|
      if loan.pay
        loan.save
        format.html { redirect_to not_pay_admin_bills_path, notice: 'unlock successfully.' }
      else
        format.html { redirect_to not_pay_admin_bills_path, notice: 'unlock faild.' }
      end
    end
  end

  def has_pay
    conditions={user:current_user,first_verify: 'verifypass',basic_verify: 'verifypass',customer_verify: 'verifypass',car_verify: 'verifypass',has_pay: true}

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
      send_data data, filename: "审核成功详单-#{Date.today}.csv"
    end
  end

  def has_pay_financial
    if !current_user.have_power('caiwu')
      redirect_to power_admin_dashboard_index_path
    end

    conditions={first_verify: 'verifypass',review_verify: 'verifypass',pay_verify: 'verifypass',has_pay: true}

    if params[:export].present?
      @loans=Loan.where(conditions).order(created_at: :desc)
    else
      @loans=Loan.where(conditions).order(created_at: :desc).page(params[:page]).per(10)
    end


    if params[:export].present?
      data = CSV.generate(headers: true) do |csv|
        csv << ['合同编号', '地区', '借款人姓名', '贷款金额', '利率','期数','每月还款金额','还款日', '身份证', '联系方式']

        for i in 0..@loans.length-1
          ele = @loans[i]
          csv << [ele.loan_message.htxlh, ele.user.location, ele.name, ele.jkje,
                  ele.product.lx, ele.jkqx,'每月还款金额', (ele.instalments[0].present? ? (ele.instalments[0].overdue_time-1.days).strftime("%d") : ''),
                  ele.loan_message.sfz, ele.loan_message.yddh]
        end
      end
      send_data data, filename: "审核成功详单-#{Date.today}.csv"
    end
  end

  def instalment
    @loan=Loan.find(params[:id])
  end

  def repay
    instalment=Instalment.find(params[:id])

    instalment.has_repay=true
    respond_to do |format|
      if instalment.can_repay
        RepayLog.create({instalment:instalment,balance:instalment.balance,no:'后台提交'})
        format.html { redirect_back(fallback_location: root_path) }
      else
        format.html { redirect_back(fallback_location: root_path) }
      end
    end
  end

  def salesman_report
    conditions={}

    start_date = '2016-01-01'
    end_date = DateTime.now

    params[:starttime].present? &&
        start_date = params[:starttime].to_datetime.beginning_of_day

    params[:endtime].present? &&
        end_date = params[:endtime].to_datetime.end_of_day

    params[:location].present? &&
        conditions.merge!({location: params[:location]})

    conditions.merge!({pass_time: start_date..end_date})

    loans=Loan.where(conditions)

    params[:name].present? &&
        loans=loans.where("id in (select loan_id from basic_messages where zdr='"+params[:name]+"')")

    @loans=loans.page(params[:page]).per(10)

    @zdrs=BasicMessage.where(loan:Loan.where({pass_time: '2017-01-01'..end_date})).group(:zdr).select(:zdr)
  end

  def performance_report
    if request.post?
      conditions={}

      start_date = '2016-01-01'
      end_date = DateTime.now

      params[:starttime].present? &&
          start_date = params[:starttime].to_datetime.beginning_of_day

      params[:endtime].present? &&
          end_date = params[:endtime].to_datetime.end_of_day

      params[:yyb].present? &&
          conditions.merge!({location:params[:yyb]})

      conditions.merge!({pass_time: start_date..end_date})
      conditions.merge!({has_pay: true,location:current_user.get_locations})

      loans=Loan.where(conditions)


      params[:cplx].present? &&
          loans=loans.where("id in (select loan_id from basic_messages where dklx='"+params[:cplx]+"')")



      #交易量
      jyl=BasicMessage.where(loan:loans).sum(:zjkje)

      #交易笔数
      jybs=loans.count


      #借款取数
      dkqx=BasicMessage.where(loan:loans).sum('dkqx+0')

      #抵押笔数
      dy_jybs=loans.where("id in (select loan_id from basic_messages where dbfs='抵押')").count

      #抵押金额
      dy_jyl=BasicMessage.where(loan:loans,dbfs:'抵押').sum(:zjkje)

      #质押笔数
      zy_jybs=loans.where("id in (select loan_id from basic_messages where dbfs='质押')").count

      #质押金额
      zy_jyl=BasicMessage.where(loan:loans,dbfs:'质押').sum(:zjkje)

      #新增人数
      xzbs=loans.where("id in (select loan_id from basic_messages where dkxs='新增')").count

      #新增金额
      xzje=BasicMessage.where(loan:loans,dkxs:'新增').sum(:zjkje)

      #贷款余额
      dkye=Instalment.where(has_repay: false).sum(:bj)

      #贷款人数
      dkrs=loans.group(:idcard).count.count


      render json:{code:1,data:{jybs:jybs,jyl:jyl,dkqx:dkqx,dy_jybs:dy_jybs,dy_jyl:dy_jyl,
                                zy_jybs:zy_jybs,zy_jyl:zy_jyl,xzbs:xzbs,xzje:xzje,dkye:dkye,dkrs:dkrs}}
    end
  end

end