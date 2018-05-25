# coding: utf-8
class Agent::DashboardController <  Agent::BaseController
  def index
  end

  def get_data
    cz_conditions={user:User.where(father_id:current_user.id,profile_id:3),status:Payment::VERIFYPASS,payment_type: 1}
    chongzhi=Payment.where(cz_conditions).sum(:balance)

    tx_conditions={user:User.where(father_id:current_user.id,profile_id:3),status:Payment::VERIFYPASS,payment_type: 0}
    tixian=Payment.where(tx_conditions).sum(:balance)

    # @startTime = Time.new - 604800
    @startTime = (Time.now - 7.day).beginning_of_day
    @endTime = (Time.now - 1.day).at_end_of_day
    chongzhi_list=Payment.where(user_id: current_user.id,status: Payment::VERIFYPASS,payment_type: 1,updated_at:[@startTime..@endTime]).group('DATE_FORMAT(payments.updated_at,"%m-%d")').sum(:balance)
    tixian_list=Payment.where(user_id: current_user.id,status: Payment::VERIFYPASS,payment_type: 0,updated_at:[@startTime..@endTime]).group('DATE_FORMAT(payments.updated_at,"%m-%d")').sum(:balance)


    yh_conditions={profile_id:3,father_id:current_user.id}
    yonghu=User.where(yh_conditions).count

    dl_conditions={profile_id:2,father_id:current_user.id}
    daili=User.where(dl_conditions).count

    render json:{cz:chongzhi,tx:tixian,dl:daili,yh:yonghu,chongzhi_list:chongzhi_list,tixian_list:tixian_list}
    return
  end
end
