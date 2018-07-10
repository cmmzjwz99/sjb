class SettlementTask
  include Sidekiq::Worker

  sidekiq_options queue: 'settlement'

  def perform(game_id)
    game=Game.find(game_id)
    game.orders.each do |ele|
      if ele.status==0 && ele.game.status==1
        ele.settlement
      end
    end
  end
end