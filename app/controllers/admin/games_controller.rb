class Admin::GamesController <  Admin::BaseController
  before_action :set_match ,only: [:show]
  def index
    conditions={}
    params[:name].present? &&
        conditions.merge!({name: params[:name]})

    # params[:id].present? && conditions.merge!({match_id: params[:id]})

    @games=Game.where(conditions).page(params[:page]).per(10)
  end

  def new
    @game=Game.new()
  end

  def show
  end

  def create
    @game= Game.new(game_params)
    respond_to do |format|
      if @game.save
        format.html {
          redirect_to admin_games_url, notice: '添加成功'
        }
      else
        format.html {
          render :new
        }
      end
    end
  end

  private
  def set_game
    @game = Match.find(params[:id])
  end
  def game_params
    params.require(:game).permit!
  end
end