class GetSscWorker
  include Sidekiq::Worker
  #获取时时彩
  def perform
    begin
      url='http://api.apiex2.com:17818/Infor_Server/api/?token=SjtLo0UPMqCPCUd9OpMiCJ5w7kUU4YcNtO57kUMlG4YcNtOv&id=20007'
      response = HTTParty.get(url, {})
      response=JSON.parse(response.to_s)
      add_game response['data'][0]
      settle_game response['data'][0]
    rescue
      GetSscWorker.perform_in(1.minutes)
    end
    #OddsWorker.perform_in(1.minutes)
  end

  def settle_game data
    #更新老期号
      ssc=SscGame.find_by_issue(data['preDrawIssue'])
      if ssc.present? && ssc.status==0
        ssc.code=data['preDrawCode']
        ssc.status=1
        ssc.save
        #ssc结算
        SscSettlementTask.perform_async(ssc.id)
      end
  end

  def add_game data
    #添加新期号
    ssc=SscGame.find_by_issue(data['drawIssue']) || SscGame.new()
    if ssc.id.nil?
      ssc.issue=data['drawIssue']
      ssc.time=data['drawTime']
      ssc.status=0
      ssc.save
      GetSscWorker.perform_in((ssc.time-Time.now))
    else
      GetSscWorker.perform_in(30.seconds)
    end
  end
end