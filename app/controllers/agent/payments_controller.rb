class Agent::PaymentsController < Agent::BaseController

  def index
    conditions = {}

    params[:user_id].present? &&
        conditions.merge!({user_id: params[:user_id]})

    @payments = Payment.where(conditions).page(params[:page]).per(10)
  end


end