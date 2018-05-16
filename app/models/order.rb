class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  before_create :default_point

  def default_point
    user=self.user
    user.points-=self.point
    user.save
    self.status=0
  end
end