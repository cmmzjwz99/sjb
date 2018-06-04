class Admin::MatchesController <  Admin::BaseController
  before_action :set_match ,only: [:show,:update,:get_match_id,:delete_match_id,:offline_match,:resume_match]
  def index
    conditions={}
    params[:name].present? &&
        conditions.merge!({name: params[:name].strip})
    params[:team1].present? &&
        conditions.merge!({team1: params[:team1].strip})
    params[:team2].present? &&
        conditions.merge!({team2: params[:team2].strip})
    params[:date].present? &&
        conditions.merge!({start_time:DateTime.parse(params[:date]).all_day})

    if params[:status].present?
      conditions.merge!({status: params[:status]})
      @matches=Match.where(conditions).page(params[:page]).per(10)
    else
      conditions.merge!({status: [0..9]})
      @matches=Match.online.where(conditions).page(params[:page]).per(10)
    end


  end

  def new
    @match=Match.new()
  end

  def show
  end

  def create
    @match= Match.new(match_params)
    if @match.start_time == nil
      return
    end
    respond_to do |format|
      if @match.save
        format.html {
          # redirect_to admin_matches_url, notice: '添加成功'
          redirect_to notice: '添加成功'
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
        # format.html { redirect_to  admin_matches_url, notice: '更新成功' }
        format.html { redirect_to   notice: '更新成功' }
      else
        format.html { render :edit }
      end
    end
  end

  def get_match_id
    begin
      @match.get_match_id
    end
    if @match.match_id.present?
      render json:{code:0,msg:'chenggong'}
    else
      render json:{code:1,msg:'shibai'}
    end
  end

  def delete_match_id
    if @match.update({match_id:nil})
      render json:{code:0,msg:'chenggong'}
    else
      render json:{code:1,msg:'shibai'}
    end
  end

  def offline_match
    @match.status=10
    if @match.save
      render json:{code:0,msg:'chenggong'}
    else
      render json:{code:1,msg:'shibai'}
    end
  end

  def resume_match
    @match.status=0
    if @match.save
      render json:{code:0,msg:'chenggong'}
    else
      render json:{code:1,msg:'shibai'}
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