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

  def update_odd odds
    self.odds1=odds[0]
    self.odds2=odds[1]
    if self.name=='标准盘'
      self.odds3=odds[2]
    else
      self.remark="#{ConvertUtil.handicap(odds[2])}"
      self.odds1+=1
      self.odds2+=1
    end
    self.save
  end


  def get_winner
    if status==0
      return '未结算'
    end
    case self.win_team
      when 1
        return "#{self.match.team1}"
      when 2
        return "#{self.match.team2}"
      when 3
        return "#{self.match.team3}"
      when 4
        return "#{self.match.team1} 赢半"
      when 5
        return "#{self.match.team2} 赢半"
      when 6
        return '不输不赢'
    end
  end
end