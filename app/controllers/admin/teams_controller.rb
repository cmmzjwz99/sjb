class Admin::TeamsController < Admin::BaseController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  def index
    if !current_user.have_power('user_manage')
      redirect_to power_admin_dashboard_index_path
    end
    @teams = Team.page(params[:page]).per(10)
  end

  def create
    @teams = Team.new(team_params)

    respond_to do |format|
      if @teams.save
        format.html { redirect_to admin_teams_path, notice: '创建成功' }
        format.json { render :show, status: :created, location: @teams }
      else
        format.html { render :new }
        format.json { render json: @teams.errors, status: :unprocessable_entity }
      end
    end
  end
  def new
    @team=Team.new
  end
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to admin_teams_path, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit!
  end
end