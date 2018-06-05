class Agent::AgentsController <  Agent::BaseController
  before_action :set_user ,only: [:show,:settlement,:update]
  def index
    # conditions={profile_id:2,father_id:current_user.id}
    # #conditions={}
    # params[:name].present? &&
    #   conditions.merge!({login:params[:name]})
    #
    # @users=User.where(conditions).page(params[:page]).per(10)

    conditions='not referee is null'

    if params[:login].present?
      user=User.find_by_login(params[:login])
      if user.present?
        conditions=" referee = '#{user.id}'"
      else
        conditions=" referee = '0'"
      end
    end

    @users=User.select(" referee")
               .where(conditions)
               .group("referee").page(params[:page]).per(10)

  end

  def new
    @user=User.new()
  end

  def show
    @user
    conditions = {user: User.where(father_id: @user.id)}
    @payments = Payment.where(conditions).page(params[:page]).per(10)
  end

  def create
    @user= User.new(user_params)
    @user.profile_id=2
    @user.father_id=current_user.id
    respond_to do |format|
      if @user.save
        format.html {
          redirect_to agent_agents_url, notice: '添加成功'
        }
      else
        format.html {
          redirect_to "#{new_agent_agent_url}?msg=账号已存在"
        }
      end
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit!
  end

end