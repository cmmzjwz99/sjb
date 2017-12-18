class Admin::CustomerImagesController < Admin::BaseController
  before_action :set_img, only: [:show, :edit, :update, :destroy]



  def destroy
    @img.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.json { head :no_content }
    end
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_img
    @img = CustomerImage.find(params[:id])
  end
end