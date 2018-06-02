class OddsWorker
  include Sidekiq::Worker
  #更新赔率

  def perform
    begin
      doc = Nokogiri::HTML(open('http://interface.win007.com/zq/odds.aspx'))
      Match.where({status:[0,1]}).where.not({match_id:nil}).each do |match|
        update_odds match.id,doc
      end
    end
    OddsWorker.perform_in(1.minutes)
  end

  def update_odds id,odds
    match=Match.find(id)
    odds=match.get_odds odds
    games=match.games

    #让球
    rq=games.where(name:'让球盘')[0] || Game.new({name:'让球盘',name1:'主队胜',name2:'客队胜',status:0,match:match,category:2})
    if rq.present? && odds[0].present?
      rq.update_odd odds[0]
    end

    #标准盘
    bz=games.where(name:'标准盘')[0] || Game.new({name:'标准盘',name1:'主队胜',name2:'平局',name3:'客队胜',status:0,match:match,category:3})
    if bz.present? && odds[1].present?
      bz.update_odd odds[1]
    end

    #大小球
    dx=games.where(name:'大小球')[0] || Game.new({name:'大小球',name1:'大球',name2:'小球',status:0,match:match,category:2})
    if dx.present? && odds[2].present?
      dx.update_odd odds[2]
    end

    #半场让球
    h_rq=games.where(name:'上半场让球盘')[0] || Game.new({name:'上半场让球盘',name1:'主队胜',name2:'客队胜',status:0,match:match,category:2})
    if h_rq.present? && odds[3].present?
      h_rq.update_odd odds[3]
    end

    #半场大小球
    h_dx=games.where(name:'上半场大小球')[0] || Game.new({name:'上半场大小球',name1:'大球',name2:'小球',status:0,match:match,category:2})
    if h_dx.present? && odds[4].present?
      h_dx.update_odd odds[4]
    end
  end

end