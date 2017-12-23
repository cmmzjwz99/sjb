class Instalment < ActiveRecord::Base
  belongs_to :loan
  has_many :repay_logs


  def can_repay
    if self.repay_logs.where(status:Loan::UNVERIFIED).present?
      return false
    end
    return true
  end
end