class Admin::OddsController < Admin::BaseController
  before_action :set_odd, only: [:show]

  def index
    conditions={}
    params[:home_team].present? &&
        conditions.merge!({home_team: params[:home_team]})

    @odds=Odd.where(conditions).page(params[:page]).per(10)
  end

  def new
    @odd=Odd.new()
  end

  def show
  end

  def create
    @odd= Odd.new(odd_params)
    respond_to do |format|
      if @odd.save
        format.html {
          redirect_to admin_odds_url, notice: '添加成功'
        }
      else
        format.html {
          render :new
        }
      end
    end
  end

  private
  def set_odd
    @odd = Odd.find(params[:id])
  end

  def odd_params
    params.require(:odd).permit!
  end

end