class Admin::UserAreasController < Admin::BaseController
  before_action :set_area, only: [:destroy]

  def index
    if !current_user.have_power('admin')
      redirect_to power_admin_dashboard_index_path
    end
    @user_areas=UserArea.where({}).page(params[:page]).per(10)
  end

  def new
    if !current_user.have_power('admin')
      redirect_to power_admin_dashboard_index_path
    end
    @user_area=UserArea.new()
  end

  def create
    @user_area= UserArea.new(area_params)
    respond_to do |format|
      if @user_area.save
        format.html {
          redirect_to admin_user_areas_path, notice: '添加成功'
        }
      else
        format.html {
          render :new
        }
      end
    end
  end

  def destroy
    @user_area.destroy
    respond_to do |format|
      format.html { redirect_to admin_user_areas_path, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_area
    @user_area = UserArea.find(params[:id])
  end
  def area_params
    params.require(:area).permit!
  end
end