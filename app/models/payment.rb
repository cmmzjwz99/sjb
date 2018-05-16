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
end