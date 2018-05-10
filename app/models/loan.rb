class Loan  < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  has_one :loan_message
  has_many :instalments
  has_many :loan_comments
  has_many :loan_images



  VERIFYPASS='verifypass'
  VERIFYFAIL='verifyfail'

  UNVERIFIED='unverified'


  def pay
    if self.has_pay==false
      instalments=self.get_instalment

      instalments.each do |ele|
        Instalment.create(ele)
      end

      self.has_pay=true
      self.pay_time=Time.now
      self.save
      return true
    else
      return true
    end
  end

  def get_instalment
    instalments=Array.new

    if self.product_id.present?
      product=Product.find(self.product_id)
      lx=product.lx/100
      sqlx=product.sqlx/100
      balance=self.jkje.to_f
      periods=self.jkqx.to_i
      start_time=self.start_time.end_of_day

      if product.fqlx==1
        #先息后本
        (0..periods).each do |i|
          condition=Hash.new
          condition[:overdue_time]=(start_time+i.months)
          condition[:loan_id]=self.id
          condition[:periods]=i
          condition[:overdue_time]=condition[:overdue_time]-1.days if i>0

          condition[:lx]=balance*lx
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
                self.fwf+self.wzyj+self.bxyj+
                product.bzj+product.qt+product.fxj
            condition[:fwf]=self.fwf
            condition[:wzyj]=self.wzyj
            condition[:bxyj]=self.bxyj
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
        (0..periods-1).each do |i|
          condition=Hash.new
          condition[:overdue_time]=(start_time+i.months)
          condition[:overdue_time]=condition[:overdue_time]-1.days if i>0
          condition[:loan_id]=self.id
          condition[:periods]=i
          condition[:gpsllf]=product.gpsllf

          condition[:lx]=balance*lx
          condition[:lx]=IntegerUtil.convert(condition[:lx])
          condition[:bj]=(balance+balance*sqlx*periods)/periods
          condition[:bj]=IntegerUtil.convert(condition[:bj])
          condition[:balance]=condition[:lx]+condition[:bj]+condition[:gpsllf]
          if i==0
            condition[:lx]=balance*sqlx*periods
            condition[:lx]=IntegerUtil.convert(condition[:lx])
            condition[:bj]=0
            condition[:fwf]=self.fwf
            condition[:gpsfy]=product.gpsfy
            condition[:jjf]=product.jjf
            condition[:balance]=condition[:lx]+condition[:fwf]+condition[:gpsfy]+condition[:jjf]+condition[:gpsllf]
          elsif i>0 && i<4
            condition[:bj]=(balance+balance*sqlx*periods)*4/(periods*3)
            condition[:bj]=IntegerUtil.convert(condition[:bj])
            condition[:lx]=balance*lx*4/3
            condition[:lx]=IntegerUtil.convert(condition[:lx])
            condition[:gpsllf]=product.gpsllf*4/3
            condition[:gpsllf]=IntegerUtil.convert(condition[:gpsllf])
            condition[:balance]=condition[:lx]+condition[:bj]+condition[:gpsllf]
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
          condition[:lx]=balance*lx
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
                self.fwf+self.wzyj+self.bxyj+
                product.bzj+product.qt+product.fxj
            condition[:fwf]=self.fwf
            condition[:wzyj]=self.wzyj
            condition[:bxyj]=self.bxyj
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
            condition[:balance]=condition[:bj]
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

  def get_lx
    begin
      return Product.find_by_name(self.basic_message.dkcp).lx
    rescue
      return ''
    end
  end
end