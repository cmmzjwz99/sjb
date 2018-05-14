class Payment < ActiveRecord::Base
  belongs_to :user

  #成功
  VERIFYPASS=1
  #失败
  VERIFYFAIL=2
  #待审核
  UNVERIFIED=0
end