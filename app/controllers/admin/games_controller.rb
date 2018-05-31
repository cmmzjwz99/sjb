class Admin::GamesController <  Admin::BaseController
  before_action :set_game ,only: [:show,:settlement,:update]
  # @@type_id=''
  def index
    conditions={}
    params[:name].present? &&
        conditions.merge!({name: params[:name]})

    # params[:id].present? && conditions.merge!({match_id: params[:id]})
    # @@type_id = params[:type_id]
    @games=Game.where(conditions).page(params[:page]).per(10)
  end

  def new
    @game=Game.new()
  end

  def show
  end

  def settlement
    @type_id = params[:type_id]
  end

  def create
    @game= Game.new(game_params)
    @game.status=0
    @type_id = params[:type_id]
    respond_to do |format|
      if @game.save
        format.html {
          redirect_to admin_match_url(@type_id), notice: '添加成功'
        }
      else
        format.html {
          render :new
        }
      end
    end
  end


  def update
    @game.update_attributes(game_params)

    respond_to do |format|
      if @game.save(game_params)
        #结算
        @game.settlement if @game.status==1
        @type_id = params[:type_id]
        format.html { redirect_to  admin_match_path(@type_id), notice: '更新成功' }
      else
        format.html { render :edit }
      end
    end
  end

  private
  def set_game
    @game = Game.find(params[:id])
  end
  def game_params
    params.require(:game).permit!
  end
end