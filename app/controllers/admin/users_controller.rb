class Admin::UsersController <  Admin::BaseController
  def index
    conditions={profile_id:3}
    #conditions={}
    @users=User.where(conditions).page(params[:page]).per(10)
  end
end