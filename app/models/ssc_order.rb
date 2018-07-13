class SscOrder < ActiveRecord::Base
  belongs_to :user
  belongs_to :ssc_game
  #status 0未结算 1已结算

  def settlement
    if self.status!=0
      return
    end
    if SscSettlement.settlement self.category,self.ssc_game.code,self.code
      #获胜
      User.transaction do
        self.get_point=self.point*self.odds
        user=self.user
        user.points+=self.get_point
        self.status=1
        user.save
        self.save
        journal=user.ssc_journal || SscJournal.new(user:user)
        journal.point+=self.get_point-self.point
        journal.save
      end
    else
      #失败
      User.transaction do
        self.get_point=0
        self.status=1
        self.save
        user=self.user
        journal=user.ssc_journal || SscJournal.new(user:user)
        journal.point+=self.point
        journal.save
      end
    end
  end

  before_create :default_point,:default_odds

  #判断结果是否符合结果规则
  def default_code
    if self.category==19 || self.category==20 || self.category==21
      if self.code<1 || self.code>5
        return false
      end
    elsif self.category==3
      if self.code<1 || self.code>3
        return false
      end
    elsif self.category==6 || self.category==9 || self.category==12 || self.category==15 || self.category==18
      if self.code<0 || self.code>9
        return false
      end
    else
      if self.code<1 || self.code>2
        return false
      end
    end
    return true
  end

  def default_point
    user=self.user
    user.points-=self.point
    user.save
    self.status=0
  end

  def default_odds
    if  self.category==19 || self.category==20 || self.category==21
      #前三中三后三赔率
      case self.code
        #豹子 顺子 对子 半顺 其他
        when 1
          self.odds=60.0
        when 2
          self.odds=13.0
        when 3
          self.odds=2.8
        when 4
          self.odds=2.0
        when 5
          self.odds=2.2
      end
    elsif self.category==6 || self.category==9 || self.category==12 || self.category==15 || self.category==18
      #数字
      self.odds=9.7
    elsif self.category==3 && self.code==3
      #龙虎和-和
      self.odds=9.2
    else
      self.odds=1.97
    end
  end

  def get_category
    name=['','总/单双','总/大小','龙虎和',
          '单选/万','单选/万','单选/万',
          '单选/千','单选/千','单选/千',
          '单选/百','单选/百','单选/百',
          '单选/十','单选/十','单选/十',
          '单选/个','单选/个','单选/个',
          '前三','中三','后三']
    return name[self.category]
  end
  def get_code
    name=[['','单','双'],['','大','小'],['','龙','虎','和'],['','豹子','顺子','对子','半顺','杂六']]
    if self.category==1 || self.category==4 || self.category==7 || self.category==10 || self.category==13 || self.category==16
      #单双
      return name[0][self.code]
    elsif self.category==3
      #龙虎和
      return name[2][self.code]
    elsif self.category==19 || self.category==20 || self.category==21
      #三
      return name[3][self.code]
    elsif  self.category==6 || self.category==9 || self.category==12 || self.category==15 || self.category==18
      #数字
      return "#{self.code}"
    else
      #大小
      return name[1][self.code]
    end

  end
end