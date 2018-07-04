class Admin::SscGamesController <  Admin::BaseController
  before_action :set_ssc_game,only: [:show]
  def index
    conditions={}
    # params[:name].present? &&
    #     conditions.merge!({name: params[:name]})

    @sscgames=SscGame.where(conditions).page(params[:page]).per(10)
  end

  def show
  end

  private
  def set_ssc_game
    @sscgame = SscGame.find(params[:id])
  end
  def ssc_game_params
    params.require(:game).permit!
  end

end