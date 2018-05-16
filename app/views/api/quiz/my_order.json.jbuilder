json.code @orders.nil? ? 1 : 0
json.data(@orders) do |order|
  json.extract! order, :point,:get_point
  case order.status
    when 0
      json.get_point '进行中'
    when 1
      json.get_point '结算中'
    when 2
      json.get_point "#{order.get_point}"
    else
      json.get_point "-#{order.point}"
  end
  case order.team
    when 1
      json.team order.game.name1
    when 2
      json.team order.game.name2
    else
      json.team order.game.name3
  end
  json.match "#{order.game.match.name} #{order.game.match.team1}VS#{order.game.match.team2}"
  json.game order.game.name
end