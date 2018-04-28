class Admin::UsersController < Admin::BaseController

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    if !current_user.have_power('admin')
      redirect_to power_admin_dashboard_index_path
    end
    @users=User.where(profile_id:1).where('id > 2').page(params[:page]).per(10)
  end


  def show
    if !current_user.have_power('admin')
      redirect_to power_admin_dashboard_index_path
    end
  end

  # GET /users/new
  def new
    if !current_user.have_power('admin')
      redirect_to power_admin_dashboard_index_path
    end
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def create
    @user=User.new(user_params)
    @user.name=@user.login
    @user.profile_id=1
    User.transaction do
      if @user.save
          redirect_to admin_user_path(@user)
      else
        redirect_to '/admin/users/new?msg=zhycz'
      end
    end
  end

  def freeze
    @user=User.find(params[:id])
    @user.profile_id=3

    if @user.save
      redirect_to admin_users_path
    else
      redirect_to admin_users_path
    end
  end

  def update
    User.transaction do
      respond_to do |format|
        if @user.update(user_params)
          format.html {redirect_to admin_users_path, notice: 'successfully updated'}
          format.json {render :show, status: :ok, location: @loan}
        else
          format.html { render :edit }
          format.json { render json: @loan.errors, status: :unprocessable_entity }
        end
      end
    end
  end


  def recover_password
    @user=current_user
    if request.post?

      return(render json: {code: 1,msg:{errors:"此用户不存在"}}) if @user.nil?

      return(render json: {code: 1,msg:{errors:"两次输入密码不一致"}}) if params[:password] !=params[:confirm]

      respond_to do |format|
        if @user.update_password(params[:password])
          format.json {render json:{code: 0}}
        else
          format.json {render json:{code: 1,msg:{errors:"#{@user.errors.full_messages[0]}"}}}
        end
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit!
  end
end