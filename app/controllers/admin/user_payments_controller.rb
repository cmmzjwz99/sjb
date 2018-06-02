class Admin::UserPaymentsController < Admin::BaseController
  def index
    @user_payment=current_user.user_payment || UserPayment.new({alipay_status:false,wechat_status:false,bank_status:false})
  end

  def update
    @payment= current_user.user_payment
    respond_to do |format|
      if @payment.update(user_payment_params)
        format.html {
          redirect_to "#{admin_user_payments_path}?msg=保存成功"
        }
      else
        format.html {
          redirect_to "#{admin_user_payments_path}?msg=保存失败"
        }
      end
    end
  end

  def create
    @payment= UserPayment.new(user_payment_params)
    @payment.user=current_user
    respond_to do |format|
      if @payment.save
        format.html {
          redirect_to "#{admin_user_payments_path}?msg=保存成功"
        }
      else
        format.html {
          redirect_to "#{admin_user_payments_path}?msg=账号已存在"
        }
      end
    end
  end

  def save_setting
    #网站标题
    title=Setting.where(category:'')[0] || Setting.new(category:'title')
    title.val=params[:title]
    title.save
    #客服号码
    customer=Setting.where(category:'customer')[0] || Setting.new(category:'customer')
    customer.val=params[:customer]
    customer.save
    respond_to do |format|
      format.html {
        redirect_to admin_dashboard_path, notice: '添加成功'
      }
    end
  end

  private
  def user_payment_params
    params.require(:user_payment).permit!
  end

end