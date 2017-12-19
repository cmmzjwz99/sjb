class Loan  < ActiveRecord::Base
  belongs_to :user
  has_one :car_message
  has_one :customer_message
  has_one :basic_message
  has_many :instalments
  has_many :loan_comments
  has_many :loan_images


  VERIFYPASS='verifypass'
  VERIFYFAIL='verifyfail'

  UNVERIFIED='unverified'


  def pay
    if self.has_pay==false
      if self.basic_message.dkcp=='标准分期' &&  self.basic_message.dkqxdw=='月'
        balance=self.basic_message.zjkje.to_f
        periods=self.basic_message.dkqx.to_i
        start_time=Time.now.end_of_day
        (0..periods).each do |i|
          condition={loan:self,periods:i+1,overdue_time:(start_time+i.months)}
          condition[:balance]=balance/periods + balance*0.01 + 100
          condition[:bj]=balance/periods
          condition[:lx]=balance*0.01
          condition[:gpsllf]=100
          condition[:dkye]=balance*(periods-i)/periods
          if i==0
            condition[:gpsfy]=1500
            condition[:jjf]=300
            condition[:fwf]=3600
            condition[:balance]=balance*0.01 +5500
            condition[:bj]=0
          end
          if i==(periods)
            condition[:gpsllf]=0
            condition[:balance]=balance/periods
            condition[:lx]=0
          end
          Instalment.create(condition)
        end
      elsif self.basic_message.dkcp=='第一期还两期' &&  self.basic_message.dkqxdw=='月'
        balance=self.basic_message.zjkje.to_f
        periods=self.basic_message.dkqx.to_i
        start_time=Time.now.end_of_day
        (0..periods-1).each do |i|
          condition={loan:self,periods:i+1,overdue_time:(start_time+i.months)}
          condition[:balance]=balance/periods + balance*0.01 + 100
          condition[:bj]=balance/periods
          condition[:lx]=balance*0.01
          condition[:gpsllf]=100
          condition[:dkye]=balance*(periods-i-1)/periods
          if i==0
            condition[:gpsfy]=1500
            condition[:jjf]=300
            condition[:fwf]=3600
            condition[:balance]=balance*0.01 +5500
            condition[:bj]=0
            condition[:dkye]=balance
          end
          if i==1
            condition[:balance]=(balance/periods + balance*0.01)*2 + 100
            condition[:bj]=(balance/periods)*2
            condition[:lx]=(balance*0.01)*2
          end
          if i==(periods-1)
            condition[:balance]=balance/periods+100
            condition[:lx]=0
          end
          Instalment.create(condition)
        end
      end
      self.has_pay=true
      self.save
      return true
    else
      return true
    end
  end

  def get_status(name)
    if name=='verifypass'
      return '审核通过'
    elsif name=='verifyfail'
      return '审核失败'
    elsif name=='unverified'
      return '审核中'
    end
  end
end