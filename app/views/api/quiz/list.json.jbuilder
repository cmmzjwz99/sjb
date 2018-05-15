json.code @matchs.nil? ? 1 : 0
json.data(@matchs) do |match|
  json.extract! match, :id, :name, :team1, :team2,:score1,:score2,:status
  json.games(match.games) do |game|
    json.extract! game, :id, :name,:odds1,:odds2,:status
  end
end