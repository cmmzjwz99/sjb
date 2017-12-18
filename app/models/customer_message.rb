class CustomerMessage < ActiveRecord::Base
  belongs_to :loan
  has_many :customer_images
  before_update :set_status


  def set_status
    loan=self.loan
    loan.customer_verify=self.status
    loan.save
  end
end