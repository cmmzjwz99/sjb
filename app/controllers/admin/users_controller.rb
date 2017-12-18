class Admin::UsersController < Admin::BaseController

  before_action :set_user, only: [:show, :edit, :update, :destroy,:local,:risk_unlock,:service,:update_concern]

  def index
    @users=User.where('1=1').page(params[:page]).per(10)
  end


  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
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