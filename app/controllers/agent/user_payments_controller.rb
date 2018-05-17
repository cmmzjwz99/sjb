class Agent::UserPaymentsController < Agent::BaseController
  def index
    @user_payment=current_user.user_payment || UserPayment.new()
  end

  def update
    @payment= current_user.user_payment
    respond_to do |format|
      if @payment.update(user_payment_params)
        format.html {
          redirect_to "#{agent_user_payments_path}?msg=保存成功"
        }
      else
        format.html {
          redirect_to "#{agent_user_payments_path}?msg=保存失败"
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
          redirect_to "#{agent_user_payments_path}?msg=保存成功"
        }
      else
        format.html {
          redirect_to "#{agent_user_payments_path}?msg=账号已存在"
        }
      end
    end
  end

  private
  def user_payment_params
    params.require(:user_payment).permit!
  end

end