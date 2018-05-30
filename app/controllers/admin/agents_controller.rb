class Admin::AgentsController < Admin::BaseController
  before_action :set_user ,only: [:show,:settlement,:update]
  def index
    conditions={profile_id: 2}
    #conditions={}
    params[:name].present? &&
        conditions.merge!({login: params[:name]})

    @users=Agent.where(conditions).page(params[:page]).per(10)
  end

  def new
    @user=Agent.new()
  end

  def show
    @user
    conditions = {user: User.where(father_id: @user.id)}
    @payments = Payment.where(conditions).page(params[:page]).per(10)
  end
  

  def create
    @user= Agent.new(user_params)
    @user.profile_id=2
    respond_to do |format|
      if @user.save
        format.html {
          redirect_to admin_agents_url, notice: '添加成功'
        }
      else
        format.html {
          redirect_to "#{new_admin_agent_url}?msg=账号已存在"
        }
      end
    end
  end

  private
  def set_user
    @user = Agent.find(params[:id])
  end

  def user_params
    params.require(:user).permit!
  end

end