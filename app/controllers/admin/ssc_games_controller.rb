class Admin::SscGamesController <  Admin::BaseController
  before_action :set_ssc_game,only: [:show]
  def index
    conditions={}
    params[:issue].present? &&
        conditions.merge!({issue: params[:issue].strip})
    params[:code].present? &&
        conditions.merge!({code: params[:code].strip})
    params[:date].present? &&
        conditions.merge!({time:DateTime.parse(params[:date]).all_day})

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