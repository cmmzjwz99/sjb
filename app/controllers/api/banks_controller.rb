class Api::BanksController < Api::BaseController
  def info
    @bank= current_user.user_bank || UserBank.new(bank:'',no:'',name:'')
  end

  def update_bank
    @bank= current_user.user_bank || UserBank.new(user:current_user)
    @bank.save
    @bank.update_attributes(bank_params)

      if @bank.save
        render json:{code:0,msg:'success'}
        return
      else
         render json:{code:1,msg:'fail'}
        return
      end
  end

  private
  def bank_params
    params.require(:bank).permit!
  end
end