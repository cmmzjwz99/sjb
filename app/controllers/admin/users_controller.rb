class Admin::UsersController <  Admin::BaseController
  before_action :set_user ,only: [:show,:settlement,:update]
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

  private
  def set_user
    @user = User.find(params[:id])
  end
  def game_params
    params.require(:user).permit!
  end
end