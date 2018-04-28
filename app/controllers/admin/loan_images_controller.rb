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


  def uploadimg
    @loan=Loan.find(params[:loan_id])
    img=LoanImage.new(loan:@loan)
    img.img=params[:img]
    img.style=params[:typename]
    if img.save
      render json: {code:0,data:{url:img.img.url,name:img.img.url.split('/').last,date:img.created_at.strftime('%Y-%m-%d %H:%M:%S'),id:img.id,type:img.style}}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_img
    @loanimg = LoanImage.find(params[:id])
  end
end