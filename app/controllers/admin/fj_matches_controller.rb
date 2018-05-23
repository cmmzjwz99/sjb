class Admin::FjMatchesController <  Admin::BaseController
  def index
    @matches=FjMatch.where(' match_id NOT IN (SELECT match_id FROM matchs where match_id is not null)').page(params[:page]).per(10)
  end

  def add_match
    fj_match=FjMatch.find(params[:id])
    fj_match.add_to_match
    respond_to do |format|
      format.html {redirect_to admin_fj_matches_path}
    end
  end
end