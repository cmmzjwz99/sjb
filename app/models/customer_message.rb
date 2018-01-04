class CustomerMessage < ActiveRecord::Base
  belongs_to :loan
  has_many :customer_images
  before_update :set_status


  def set_status
    loan=self.loan
    loan.customer_verify=self.status
    loan.save
  end


  def verify_pass(user)
    self.verify_user=user.id
    self.verify_time=Time.now
    loan=self.loan
    if loan.car_message.status==Loan::VERIFYPASS
      loan.pass_time=Time.now
      loan.save
    end
  end
end