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
      product=Product.find_by_name(self.basic_message.dkcp)
      lx=product.lx
      balance=self.basic_message.zjkje.to_f
      periods=self.basic_message.dkqx.to_i
      start_time=Time.now.end_of_day

      if product.fqlx==1
        #先息后本
        (0..periods).each do |i|
          condition={loan:self,periods:i,overdue_time:(start_time+i.months)}
          condition[:overdue_time]=condition[:overdue_time]-1.days if i>0

          condition[:lx]=balance*lx/100
          condition[:dkye]=balance
          condition[:bj]=0
          condition[:gpsllf]=product.gpsllf
          condition[:balance]=condition[:lx]+condition[:bj]+condition[:gpsllf]
          if i==0
            condition[:balance]=condition[:lx]+product.gpsllf+product.gpsfy+product.jjf+
                self.basic_message.fwf+self.basic_message.wzyj+self.basic_message.bxyj+
                product.bzj+product.qt+product.fxj
            condition[:fwf]=self.basic_message.fwf
            condition[:wzyj]=self.basic_message.wzyj
            condition[:bxyj]=self.basic_message.bxyj
            condition[:bzj]=product.bzj
            condition[:qt]=product.qt
            condition[:fxj]=product.fxj
            condition[:gpsfy]=product.gpsfy
            condition[:jjf]=product.jjf
          end
          if i==periods
            condition[:gpsllf]=0
            condition[:lx]=0
            condition[:bj]=balance
            condition[:balance]=balance
            condition[:dkye]=0
          end
          Instalment.create(condition)
        end
      elsif product.fqlx==2
        #等额本息
        (0..periods).each do |i|
          condition={loan:self,periods:i,overdue_time:(start_time+i.months)}
          condition[:overdue_time]=condition[:overdue_time]-1.days if i>0

          condition[:lx]=balance*lx/100
          condition[:dkye]=balance*(periods-i)/periods
          condition[:bj]=balance/periods
          condition[:gpsllf]=product.gpsllf
          condition[:balance]=condition[:lx]+condition[:bj]+condition[:gpsllf]
          if i==0
            condition[:balance]=condition[:lx]+product.gpsllf+product.gpsfy+product.jjf+
                self.basic_message.fwf+self.basic_message.wzyj+self.basic_message.bxyj+
                product.bzj+product.qt+product.fxj
            condition[:fwf]=self.basic_message.fwf
            condition[:wzyj]=self.basic_message.wzyj
            condition[:bxyj]=self.basic_message.bxyj
            condition[:bzj]=product.bzj
            condition[:qt]=product.qt
            condition[:fxj]=product.fxj
            condition[:bj]=0
            condition[:gpsfy]=product.gpsfy
            condition[:jjf]=product.jjf
          end
          if i==periods
            condition[:gpsllf]=0
            condition[:lx]=0
          end
          Instalment.create(condition)
        end
      elsif product.fqlx==3
        #一期还两期
        dkye=balance
        (0..periods-1).each do |i|
          condition={loan:self,periods:i,overdue_time:(start_time+i.months)}
          condition[:overdue_time]=condition[:overdue_time]-1.days if i>0
          condition[:lx]=balance*lx/100
          condition[:bj]=balance/periods
          condition[:gpsllf]=product.gpsllf
          condition[:balance]=condition[:lx]+condition[:bj]+condition[:gpsllf]
          if i==0
            condition[:balance]=condition[:lx]+product.gpsllf+product.gpsfy+product.jjf+
                self.basic_message.fwf+self.basic_message.wzyj+self.basic_message.bxyj+
                product.bzj+product.qt+product.fxj
            condition[:fwf]=self.basic_message.fwf
            condition[:wzyj]=self.basic_message.wzyj
            condition[:bxyj]=self.basic_message.bxyj
            condition[:bzj]=product.bzj
            condition[:qt]=product.qt
            condition[:fxj]=product.fxj
            condition[:bj]=0
            condition[:gpsfy]=product.gpsfy
            condition[:jjf]=product.jjf
          end
          if i==product.sbqs
            condition[:bj]=condition[:bj]*2
            condition[:lx]=condition[:lx]*2
            condition[:balance]=condition[:lx]+condition[:bj]+condition[:gpsllf]
          end
          if i==periods-1
            condition[:gpsllf]=0
            condition[:lx]=0
          end
          condition[:dkye]=dkye-condition[:bj]
          dkye=dkye-condition[:bj]
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

  def get_instalment
    instalments=Array.new

    if self.basic_message.present? && self.basic_message.dkcp.present?
      product=Product.find_by_name(self.basic_message.dkcp)
      lx=product.lx
      balance=self.basic_message.zjkje.to_f
      periods=self.basic_message.dkqx.to_i
      start_time=Time.now.end_of_day

      if product.fqlx==1
        #先息后本
        (0..periods).each do |i|
          condition=Hash.new
          condition[:overdue_time]=(start_time+i.months)
          condition[:loan_id]=self.id
          condition[:periods]=i
          condition[:overdue_time]=condition[:overdue_time]-1.days if i>0

          condition[:lx]=balance*lx/100
          condition[:dkye]=balance
          condition[:bj]=0
          condition[:gpsllf]=product.gpsllf
          condition[:balance]=condition[:lx]+condition[:bj]+condition[:gpsllf]
          condition[:fwf]=0
          condition[:wzyj]=0
          condition[:bxyj]=0
          condition[:bzj]=0
          condition[:qt]=0
          condition[:fxj]=0
          condition[:gpsfy]=0
          condition[:jjf]=0
          if i==0
            condition[:balance]=condition[:lx]+product.gpsllf+product.gpsfy+product.jjf+
                self.basic_message.fwf+self.basic_message.wzyj+self.basic_message.bxyj+
                product.bzj+product.qt+product.fxj
            condition[:fwf]=self.basic_message.fwf
            condition[:wzyj]=self.basic_message.wzyj
            condition[:bxyj]=self.basic_message.bxyj
            condition[:bzj]=product.bzj
            condition[:qt]=product.qt
            condition[:fxj]=product.fxj
            condition[:gpsfy]=product.gpsfy
            condition[:jjf]=product.jjf
          end
          if i==periods
            condition[:gpsllf]=0
            condition[:lx]=0
            condition[:bj]=balance
            condition[:balance]=balance
            condition[:dkye]=0
          end
          instalments << condition
        end
      elsif product.fqlx==2
        #等额本息
        (0..periods).each do |i|
          condition=Hash.new
          condition[:overdue_time]=(start_time+i.months)
          condition[:loan_id]=self.id
          condition[:periods]=i
          condition[:overdue_time]=condition[:overdue_time]-1.days if i>0

          condition[:lx]=balance*lx/100
          condition[:dkye]=balance*(periods-i)/periods
          condition[:bj]=balance/periods
          condition[:gpsllf]=product.gpsllf
          condition[:balance]=condition[:lx]+condition[:bj]+condition[:gpsllf]
          condition[:fwf]=0
          condition[:wzyj]=0
          condition[:bxyj]=0
          condition[:bzj]=0
          condition[:qt]=0
          condition[:fxj]=0
          condition[:gpsfy]=0
          condition[:jjf]=0
          if i==0
            condition[:balance]=condition[:lx]+product.gpsllf+product.gpsfy+product.jjf+
                self.basic_message.fwf+self.basic_message.wzyj+self.basic_message.bxyj+
                product.bzj+product.qt+product.fxj
            condition[:fwf]=self.basic_message.fwf
            condition[:wzyj]=self.basic_message.wzyj
            condition[:bxyj]=self.basic_message.bxyj
            condition[:bzj]=product.bzj
            condition[:qt]=product.qt
            condition[:fxj]=product.fxj
            condition[:bj]=0
            condition[:gpsfy]=product.gpsfy
            condition[:jjf]=product.jjf
          end
          if i==periods
            condition[:gpsllf]=0
            condition[:lx]=0
          end
          instalments << condition
        end
      elsif product.fqlx==3
        #一期还两期
        dkye=balance
        (0..periods-1).each do |i|
          condition=Hash.new
          condition[:overdue_time]=(start_time+i.months)
          condition[:loan_id]=self.id
          condition[:periods]=i
          condition[:overdue_time]=condition[:overdue_time]-1.days if i>0
          condition[:lx]=balance*lx/100
          condition[:bj]=balance/periods
          condition[:gpsllf]=product.gpsllf
          condition[:balance]=condition[:lx]+condition[:bj]+condition[:gpsllf]
          condition[:fwf]=0
          condition[:wzyj]=0
          condition[:bxyj]=0
          condition[:bzj]=0
          condition[:qt]=0
          condition[:fxj]=0
          condition[:gpsfy]=0
          condition[:jjf]=0
          if i==0
            condition[:balance]=condition[:lx]+product.gpsllf+product.gpsfy+product.jjf+
                self.basic_message.fwf+self.basic_message.wzyj+self.basic_message.bxyj+
                product.bzj+product.qt+product.fxj
            condition[:fwf]=self.basic_message.fwf
            condition[:wzyj]=self.basic_message.wzyj
            condition[:bxyj]=self.basic_message.bxyj
            condition[:bzj]=product.bzj
            condition[:qt]=product.qt
            condition[:fxj]=product.fxj
            condition[:bj]=0
            condition[:gpsfy]=product.gpsfy
            condition[:jjf]=product.jjf
          end
          if i==product.sbqs
            condition[:bj]=condition[:bj]*2
            condition[:lx]=condition[:lx]*2
            condition[:balance]=condition[:lx]+condition[:bj]+condition[:gpsllf]
          end
          if i==periods-1
            condition[:gpsllf]=0
            condition[:lx]=0
          end
          condition[:dkye]=dkye-condition[:bj]
          dkye=dkye-condition[:bj]
          instalments << condition
        end

      end

    else
    end

    return instalments
  end

  def get_status(name,type)
    if name=='verifypass'
      return '审核通过'
    elsif name=='verifyfail'
      if type
        return '审核失败'
      else
        return '未提交'
      end
    elsif name=='unverified'
      return '审核中'
    end
  end

  def verify_pass(user)
    basic=self.basic_message || BasicMessage.new(loan:self)
    basic.save
    self.verify_time=Time.now
    self.verify_user=user.id
  end

  def get_location
    location=''
    location='浙江温州' if self.location=='zjwz'
    location='绍兴嵊州' if self.location=='zjsxsz'
    location='绍兴柯桥' if self.location=='zjsxkq'
    location='绍兴越城' if self.location=='zjsxyc'
    location='浙江杭州' if self.location=='zjhz'
    location='安徽合肥' if self.location=='ahhf'
    return location
  end

  def get_lx
    begin
      return Product.find_by_name(self.basic_message.dkcp).lx
    rescue
      return ''
    end
  end
end