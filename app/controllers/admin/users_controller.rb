class Admin::UsersController <  Admin::BaseController
  before_action :set_user ,only: [:show,:settlement,:update,:recover_password]
  def index
    conditions={profile_id:3}
    #conditions={}
    params[:name].present? &&
        conditions.merge!({login:params[:name]})

    params[:date].present? &&
        conditions.merge!({created_at:DateTime.parse(params[:date]).all_day})
    @users=User.where(conditions).page(params[:page]).per(10)
  end

  def show
  end

  def recover_password
    if request.post?
      if @user.update_password('123456')
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