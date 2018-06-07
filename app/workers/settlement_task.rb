class SettlementTask
  include Sidekiq::Worker

  sidekiq_options queue: 'settlement'

  def perform(order_id)
    order=Order.find(order_id)

    if order.status==1 && order.game.status==1
      order.settlement
    end

  end

end