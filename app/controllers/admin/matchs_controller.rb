class Admin::MatchsController <  Admin::BaseController
  before_action :set_match ,only: [:show]
  def index
    conditions={}
    @matchs=Match.where(conditions).page(params[:page]).per(10)
  end

  def new
    @match=Match.new()
  end

  def show
  end

  def create
    @match= Match.new(match_params)
    respond_to do |format|
      if @match.save
        format.html {
          redirect_to admin_matchs_url, notice: '添加成功'
        }
      else
        format.html {
          render :new
        }
      end
    end
  end

  private
  def set_match
    @match = Match.find(params[:id])
  end
  def match_params
    params.require(:match).permit!
  end

end