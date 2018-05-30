class Agent::UsersController <  Agent::BaseController
  before_action :set_user ,only: [:show,:settlement,:update]
  def index
    conditions={father_id:current_user.id,profile_id:3}
    @users=User.where(conditions).page(params[:page]).per(10)
  end

  def show
  end

  def recover_password
    if request.post?
      if current_user.password != User.password_hash(params[:current_password])
        render json: {code:1,msg:'原密码错误'}
        return
      end

      if current_user.update_password(params[:password])
        render json: {code:0,msg:'修改成功'}
        return
      end
    end
  end


  private
  def set_user
    @user = User.find(params[:id])
  end
  def game_params
    params.require(:user).permit!
  end
end