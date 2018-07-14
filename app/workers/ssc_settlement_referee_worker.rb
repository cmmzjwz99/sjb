class SscSettlementRefereeWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence  { daily.hour_of_day(3).minute_of_hour(00) }
  #每日更新昨日记录，
  def perform
    user=User.where('id in (select referee from user_referees group by referee)')
    SscJournal.transaction do
      user.each do |ele|
        ssc_journal=ele.ssc_journal || SscJournal.new({user:ele})
        ssc_referees=User.where("id in (select user from user_referees where referee=#{ele.id})")
        ssc_journal.journal=SscJournal.where(user:ssc_referees).sum('point')
        ssc_journal.save
      end
      user.each do |ele|
        ssc_journal=ele.ssc_journal || SscJournal.new({user:ele})
        ssc_journal.income=get_income ele.id
        ssc_journal.save
      end
    end
    if Time.now.wday==1
      #如果是周一则总结
      settlement_week
    end
  end

  #周log
  def settlement_week
    user=User.where('id in (select referee from user_referees group by referee)')
    user.each do |ele|
      ssc_journal=SscJournalLog.new({user:ele,time:
          "#{(Time.now-8.days).strftime('%Y.%m.%d')}-#{(Time.now-1.days).strftime('%Y.%m.%d')}"})
      ssc_journal.journal=ele.ssc_journal.journal
      ssc_journal.income=ele.ssc_journal.income
      if ssc_journal.journal>0
        ssc_journal.save
      end
    end
    SscJournal.update(point:0,journal:0,income:0)
  end

  #获取应得
  def get_income id
    income=0
    user=User.find(id)
    user_journal=user.ssc_journal || SscJournal.new(user:user)
    user_factor=get_factor user_journal.journal
    User.where(referee:user.id.to_s).each do |ele|
      journal=ele.ssc_journal || SscJournal.new(user:ele)
      income+=(user_factor- get_factor(journal.journal))*journal.journal
    end
    income+=(user_factor*SscJournal.where("user_id in (select id from users where referee='#{user.id}')").sum('point'))

    return income
  end

  #获取对应金额的系数
  def get_factor num
    return 0 if(num<10000)
    return 0.007 if(num<100000)
    return 0.008 if(num<300000)
    return 0.009 if(num<600000)
    return 0.010 if(num<1000000)
    return 0.012 if(num<2000000)
    return 0.014 if(num<4000000)
    return 0.016 if(num<6000000)
    return 0.018 if(num<8000000)
    return 0.020 if(num<10000000)
    return 0.022
  end
end