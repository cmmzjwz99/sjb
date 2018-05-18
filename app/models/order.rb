class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  before_create :default_point

  #status 0未结算 1结算中 2获胜 3失败

  def default_point
    user=self.user
    user.points-=self.point
    user.save
    self.status=0
  end

  def win
    user=self.user
    user.points+=self.get_point
    self.status=2
    self.save
    user.save
  end

  def fail
    self.status=3
    self.save
  end
end