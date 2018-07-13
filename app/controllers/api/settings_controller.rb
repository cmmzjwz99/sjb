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

    user1=current_user.referee_user_1
    user2=current_user.referee_user_2
    user3=current_user.referee_user_3

    journal=current_user.effective_journal
    rebate=current_user.rebate
    coefficient1=Setting.where(category:'rebate')[0] || Setting.new(val:'0')
    coefficient2=Setting.where(category:'rebate2')[0] || Setting.new(val:'0')
    coefficient3=Setting.where(category:'rebate3')[0] || Setting.new(val:'0')

    render json:{code:0,data:
        {url:url, user1:user1,user2:user2,user3:user3, rebate:rebate,
         coefficient1:coefficient1.val.to_f,coefficient2:coefficient2.val.to_f,coefficient3:coefficient3.val.to_f,
         journal1:current_user.effective_journal1,journal2:current_user.effective_journal2,
         journal3:current_user.effective_journal3,income:current_user.sum_journal,

        }
    }
  end

  def get_ssc_referee
    url_val=Setting.where(category:'url')[0] || Setting.new()
    url="http://#{url_val.val}/login.html?"
    if current_user.father_id.present?
      url+='ag='+current_user.father_id.to_s+'&'
    end
    url+='referee='+current_user.id.to_s
    @url=url

    @journal=current_user.ssc_journal || SscJournal.new(user:current_user)
    @journal_log=current_user.ssc_journal_logs
  end
end