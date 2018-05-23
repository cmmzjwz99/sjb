class FjMatch < ActiveRecord::Base


  def add_to_match
    match=Match.new({score1:0,score2:0,status:0})
    match.name=self.name
    match.team1=self.team1
    match.team2=self.team2
    match.start_time=self.time
    match.match_id=self.match_id
    match.save
  end
end