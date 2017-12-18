class Loan  < ActiveRecord::Base
  belongs_to :user
  has_one :car_message
  has_one :customer_message
  has_many :instalments
  has_many :loan_comments

  before_create :create_default

  def create_default

  end
end