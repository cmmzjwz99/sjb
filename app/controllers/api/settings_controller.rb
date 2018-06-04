class Api::SettingsController < Api::BaseController
  def title
    title=Setting.where(category:'title')[0] || Setting.new()
    render json:{code:0,data:title.val}
  end

  def customer
    customer=Setting.where(category:'customer')[0] || Setting.new()
    render json:{code:0,data:customer.val}
  end

  def get_referee
    url='http://sjb1289.com//index.html?'
    if current_user.father_id.present?
      url+='ag='+current_user.father_id.to_s+'&'
    end
    url+='referee='+current_user.id.to_s

    user=User.where(referee:current_user.id,father_id:current_user.father_id)

    journal=Payment.where(user:user,payment_type: true,status: 1).sum(:balance)

    render json:{code:0,data:{url:url,user:user.count,journal:journal}}
  end
end