class Admin::MembersController < Admin::BaseController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  def get_members
    members=Team.find_by_name(params[:team]).members

    arr=[]
    members.each do |ele|
      arr << ele.name
    end

    render json:{code:1,data:arr}
  end

  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_back(fallback_location: root_path) }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path)}
      format.json { head :no_content }
    end
  end
  private
  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit!
  end
end