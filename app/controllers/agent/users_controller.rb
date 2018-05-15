class Agent::UsersController <  Agent::BaseController
  def index
    conditions={father_id:current_user.id,profile_id:3}
    @users=User.where(conditions).page(params[:page]).per(10)
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
end