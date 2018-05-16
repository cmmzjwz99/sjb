json.code @games.nil? ? 1 : 0
json.data(@games) do |game|
  json.extract! game, :id, :odds1, :odds2,:odds3
end