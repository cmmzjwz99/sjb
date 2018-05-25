module ApplicationHelper

  def chongzhi_total
    @payment=Payment.where(status: Payment::VERIFYPASS,payment_type: 1)
    @sum = 0
    @payment.each do |ele|
      @sum +=ele.balance
    end
    @sum
  end

  def tixian_total
    @payment=Payment.where(status: Payment::VERIFYPASS,payment_type: 0)
    @sum = 0
    @payment.each do |ele|
      @sum +=ele.balance
    end
    @sum
  end

  def user_number
    User.where(profile_id: 3).count
  end


  def daili_number
    User.where(profile_id: 2).count
  end

  def dl_chongzhi_total
    @payment=Payment.where(status: Payment::VERIFYPASS,payment_type: 1,user:User.where(father_id:current_user.id))
    @sum = 0
    @payment.each do |ele|
      @sum +=ele.balance
    end
    @sum
  end

  def dl_tixian_total
    @payment=Payment.where(status: Payment::VERIFYPASS,payment_type: 0,user:User.where(father_id:current_user.id))
    @sum = 0
    @payment.each do |ele|
      @sum +=ele.balance
    end
    @sum
  end

  def dl_user_number
    User.where(father_id:current_user.id,profile_id:3).count
  end


  def dl_daili_number
    User.where(profile_id:2,father_id:current_user.id).count
  end

  def chongzhi_day
    Payment.where(status: Payment::VERIFYPASS,payment_type: 1).group('DATE_FORMAT(payments.updated_at,"%Y-%m-%d")').sum(:balance)
  end


end
