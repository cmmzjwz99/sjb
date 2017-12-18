class BasicMessage < ActiveRecord::Base
  belongs_to :loan

  mount_uploader :sqb, ResourceUploader
  mount_uploader :clxxb, ResourceUploader
  mount_uploader :cljcb, ResourceUploader
  mount_uploader :yybspb, ResourceUploader
  mount_uploader :csb, ResourceUploader

  before_update :set_status


  def set_status
    loan=self.loan
    loan.basic_verify=self.status
    loan.save
    if loan.basic_verify==Loan::VERIFYPASS
      customer=loan.customer_message || CustomerMessage.new(loan:loan)
      customer.save
      car=loan.car_message || CarMessage.new(loan:loan)
      car.save
    end
  end
end