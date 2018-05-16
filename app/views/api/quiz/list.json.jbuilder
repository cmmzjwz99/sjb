json.code @matchs.nil? ? 1 : 0
json.data(@matchs) do |match|
  json.extract! match, :id, :name, :team1, :team2,:score1,:score2,:status
  json.date match.start_time.strftime('%Y-%m-%d')
  json.time match.start_time.strftime('%H:%M')
  json.games(match.games) do |game|
    json.extract! game, :id, :name,:odds1,:odds2,:odds3,:status,:name1,:name2,:name3
  end
end