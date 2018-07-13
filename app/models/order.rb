class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  before_create :default_point

  #status 0未结算 1结算中 2已结算

  def default_point
    user=self.user
    user.points-=self.point
    user.save
    self.status=0
  end

  def settlement
    user=self.user
    game=self.game
    agent=User.where(id:user.referee.to_i)[0] || User.find(1)
    journal=user.ssc_journal || SscJournal.new(user:user)
    status=game.win_team
    if status==1 || status==2 || status==3
      #独赢
      if self.team==status
        user.points+=self.get_point
        self.income_point=self.get_point
        agent.effective_journal+=self.get_point-self.point
        journal.point+=self.get_point-self.point
      else
        self.income_point=0
        agent.effective_journal+=self.point
        journal.point+=self.point
      end
    elsif status ==4 || status ==5
      #赢半输半
      if (self.team+3)==status
        user.points+=((self.get_point-self.point)/2)+self.point
        self.income_point=((self.get_point-self.point)/2)+self.point
        agent.effective_journal+=((self.get_point-self.point)/2)
        journal.point+=((self.get_point-self.point)/2)
      else
        user.points+=(self.point/2)
        self.income_point=(self.point/2)
        agent.effective_journal+=(self.point/2)
        journal.point+=(self.point/2)
      end
    elsif status==6
      #不输不赢
      user.points+=self.point
      self.income_point=self.point
    elsif status==7
      #全输
      self.income_point=0
      agent.effective_journal+=self.point
      journal.point+=self.point
    end
    agent.save
    journal.save
    user.save
    self.status=2
    self.save
  end

  def get_team
    if self.team==1
      return self.game.name1
    elsif self.team==2
      return self.game.name2
    elsif self.team==3
      return self.game.name3
    end
  end
end