class Admin::SscGamesController <  Admin::BaseController
  before_action :set_ssc_game,only: [:show,:settlement]
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

  def settlement
    if params[:code].length==5 && @sscgame.status==0
      SscGame.transaction do
        @sscgame.code=params[:code]
        @sscgame.status=1
        @sscgame.save
        SscSettlementTask.perform_async(@sscgame.id)
      end
    end
    respond_to do |format|
      format.html { redirect_back(fallback_location: admin_fj_matches_path)}
    end

  end

  private
  def set_ssc_game
    @sscgame = SscGame.find(params[:id])
  end
  def ssc_game_params
    params.require(:game).permit!
  end

end