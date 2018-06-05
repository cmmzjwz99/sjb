class Admin::RefereesController < Admin::BaseController
  before_action :set_user, only: [:show,:settlement,:update]

  def index
    # conditions={referee:users.group(referee)}
    conditions={}
    params[:login].present? &&
        conditions.merge!({login: params[:login]})
    params[:date].present? &&
        conditions.merge!({created_at: DateTime.parse(params[:date]).all_day})


      # @users=User.where(conditions).find_by_sql(["select referee from users group by referee"])
    # @users=[]
    # @orders = User.where(conditions).group_by{|e|e.referee}
    # @users=@orders.first[1]

    start_date = '2018-06-01'
    end_date = DateTime.now

    params[:s_time].present? &&
        start_date = params[:s_time].to_datetime.beginning_of_day

    params[:e_time].present? &&
        end_date = params[:e_time].to_datetime.end_of_day

    conditions.merge!({created_at: start_date..end_date})

    @users=User.where(conditions).group_by{|e| e.referee}.first[1]


    # @users=User.select("referee").group("referee")

  end


  private
  def set_user
    @user = User.find(params[:id])
  end
end