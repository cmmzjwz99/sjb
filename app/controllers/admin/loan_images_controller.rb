class Admin::LoanImagesController< Admin::BaseController

  before_action :set_img, only: [:show, :edit, :update, :destroy]


  def show

  end

  def destroy
    @loanimg.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.json { head :no_content }
    end
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_img
    @loanimg = LoanImage.find(params[:id])
  end
end