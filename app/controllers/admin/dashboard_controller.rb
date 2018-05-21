# coding: utf-8
class Admin::DashboardController <  Admin::BaseController
  def index
  end

  def get_data
    cz_conditions={user:User.where(father_id:current_user.id,profile_id:3),status:Payment::VERIFYPASS,payment_type: 1}
    chongzhi=Payment.where(cz_conditions).sum(:balance)

    tx_conditions={user:User.where(father_id:current_user.id,profile_id:3),status:Payment::VERIFYPASS,payment_type: 0}
    tixian=Payment.where(tx_conditions).sum(:balance)

    yh_conditions={profile_id:3,father_id:current_user.id}
    yonghu=User.where(yh_conditions).count

    dl_conditions={profile_id:2,father_id:current_user.id}
    daili=User.where(dl_conditions).count

    render json:{cz:chongzhi,tx:tixian,dl:daili,yh:yonghu}
    return
  end
end
