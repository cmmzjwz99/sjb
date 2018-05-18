class Game < ActiveRecord::Base
  belongs_to :match
  has_many :orders
  #status 0不可结算 1可结算
  #category 获胜队伍 1 2 3

  def settlement
    self.orders.update_all({status:1})
    self.orders.each do |ele|
      SettlementTask.perform_in(30.seconds,ele.id)
    end
  end

  def get_winer
    if self.category==1
      return self.name1
    elsif self.category==2
      return self.name2
    elsif self.category==3
      return self.name3
    end
  end
end