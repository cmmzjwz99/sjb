class SettlementTask
  include Sidekiq::Worker

  sidekiq_options queue: 'settlement'

  def perform(order_id)
    order=Order.find(order_id)
    return if order.status!=1

    return if order.game.status!=1

    if order.team==order.game.win_team
      #获胜
      order.win
    else
      #失败
      order.fail
    end
  end

end