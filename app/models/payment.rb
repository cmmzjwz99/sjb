class Payment < ActiveRecord::Base
  belongs_to :user

  #成功
  VERIFYPASS=1
  #失败
  VERIFYFAIL=2
  #待审核
  UNVERIFIED=0

  def pay
    user=self.user
    user.points+=self.balance
    user.save
  end

  def rebate_fail
    user=self.user
    user.rebate-=self.balance
    user.save
  end

  def ssc_rebate_fail
    user=self.user
    journal=user.ssc_journal || SscJournal.new(user:user)
    journal.rebate-=self.balance
    journal.save
  end
end