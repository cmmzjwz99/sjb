json.code @orders.nil? ? 1 : 0
json.data(@orders) do |order|
  json.extract! order, :point,:get_point
  json.time order.created_at.strftime('%Y-%m-%d')
  case order.status
    when 0
      json.get_point '进行中'
    when 1
      json.get_point '结算中'
    when 2
      json.get_point "#{order.income_point}"
  end
  case order.team
    when 1
      json.team "#{order.game.name1} #{order.odds}"
    when 2
      json.team "#{order.game.name2} #{order.odds}"
    else
      json.team "#{order.game.name3} #{order.odds}"
  end
  #json.match "#{order.game.match.name} #{order.game.match.team1}VS#{order.game.match.team2}"
  json.match "#{order.game.match.team1}VS#{order.game.match.team2}"
  json.game order.game.name
end