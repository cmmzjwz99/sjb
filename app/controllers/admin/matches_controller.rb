class Admin::MatchesController <  Admin::BaseController
  before_action :set_match ,only: [:show,:update]
  def index
    conditions={}
    params[:name].present? &&
        conditions.merge!({name: params[:name]})
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
          redirect_to admin_matches_url, notice: '添加成功'
        }
      else
        format.html {
          render :new
        }
      end
    end
  end

  def update
    @match.update_attributes(match_params)
    respond_to do |format|
      if @match.save(match_params)
        format.html { redirect_to  admin_matches_url, notice: '更新成功' }
      else
        format.html { render :edit }
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