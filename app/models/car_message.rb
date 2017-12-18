class CarMessage < ActiveRecord::Base
  belongs_to :loan

  before_update :set_status


  def set_status
    loan=self.loan
    loan.car_verify=self.status
    loan.save
  end
end