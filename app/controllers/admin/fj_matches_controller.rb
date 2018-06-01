class Admin::FjMatchesController <  Admin::BaseController
  def index
    sql=''

    params[:name].present? &&
        sql="name like '%#{params[:name]}%'"
    params[:team1].present? &&
        sql="team1 like '%#{params[:team1]}%'"
    params[:team2].present? &&
        sql="team2 like '%#{params[:team2]}%'"
    params[:date].present? &&
        sql="time like '%#{params[:date]}%'"

    @matches=FjMatch.where(' match_id NOT IN (SELECT match_id FROM matchs where match_id is not null)')
                    .where(sql).order(:time).page(params[:page]).per(10)
  end

  def add_match
    fj_match=FjMatch.find(params[:id])
    fj_match.add_to_match
    respond_to do |format|
      # format.html {redirect_back (fallback_location: admin_fj_matches_path)}
      format.html { redirect_back(fallback_location: admin_fj_matches_path)}
    end
  end
end