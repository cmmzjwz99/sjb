class OddsWorker
  include Sidekiq::Worker
  #更新赔率

  def perform
    begin
      Match.where({status:[0,1]}).not.where({match_id:nil}).each do |match|
        update_odds match.id
      end
    end
    OddsWorker.perform_in(1.minutes)
  end

  def update_odds id
    match=Match.find(id)
    odds=match.get_odds
    games=match.games

    #让球
    rq=games.where(name:'让球盘')[0]
    if rq.present?
      rq.update_odd odds[0]
    end

    #标准盘
    bz=games.where(name:'标准盘')[0]
    if bz.present?
      bz.update_odd odds[1]
    end

    #大小球
    dx=games.where(name:'大小球')[0]
    if dx.present?
      dx.update_odd odds[2]
    end

    #半场让球
    h_rq=games.where(name:'半场让球盘')[0]
    if h_rq.present?
      h_rq.update_odd odds[3]
    end

    #半场大小球
    h_dx=games.where(name:'半场大小球')[0]
    if h_dx.present?
      h_dx.update_odd odds[4]
    end
  end

end