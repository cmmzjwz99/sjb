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
    url_val=Setting.where(category:'url')[0] || Setting.new()
    url="http://#{url_val.val}/login.html?"
    if current_user.father_id.present?
      url+='ag='+current_user.father_id.to_s+'&'
    end
    url+='referee='+current_user.id.to_s

    user=User.where(referee:current_user.id,father_id:current_user.father_id)

    journal=current_user.effective_journal
    rebate=current_user.rebate
    coefficient=Setting.where(category:'rebate')[0] || Setting.new(val:'0')

    render json:{code:0,data:
        {url:url,user:user.count,journal:journal,rebate:rebate,coefficient:coefficient.val.to_f}
    }
  end
end