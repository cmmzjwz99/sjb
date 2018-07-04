class SscSettlementTask
  include Sidekiq::Worker
  #结算时时彩
  def perform id
    ssc=SscGame.find(id)
    orders=ssc.ssc_orders
    orders.each do |ele|
      ele.settlement
    end
  end
end