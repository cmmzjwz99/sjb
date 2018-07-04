json.code @orders.nil? ? 1 : 0
json.data(@orders) do |order|
  json.extract! order, :point
  json.issue order.ssc_game.issue
  json.category "#{order.get_category}"
  json.odds "#{order.get_code} #{order.odds}"
  json.get_point (order.status==1 ? order.get_point.round(2) : '进行中')
  json.time order.created_at.strftime('%Y-%m-%d')
end