class Api::SscController < Api::BaseController
  def ssc
    @next=SscGame.where(status:0).last
    @now=SscGame.where(status:1).last
    render json:{
        code:0,
        data:{
            id:@next.id,
            next_issue:@next.issue,
            now_issue:@now.issue,
            next_time:@next.time.strftime('%Y-%m-%d %H:%M:%S'),
            now_code:@now.code,
            now_time:Time.now.strftime('%Y-%m-%d %H:%M:%S')
        }
    }
  end

  def order
    @order= SscOrder.new(order_params)
    if !(@order.ssc_game.present?)
      render json:{code:1,msg:'期号错误'}
      return
    end
    if Time.now>(@order.ssc_game.time-1.minutes)
      render json:{code:2,msg:'本期已结束投注，不可购买'}
      return
    end
    @order.user_id=current_user.id
    if @order.user.points<@order.point
      render json:{code:1,msg:'金币不足'}
      return
    end
    if @order.point<0
      render json:{code:1,msg:'下注金额不能小于0'}
      return
    end
    if !(@order.default_code)
      render json:{code:1,msg:'订单信息错误'}
      return
    end
    @order.status=0
    @order.default_odds
    if @order.save
      render json:{code:0,msg:'成功'}
    else
      render json:{code:1,msg:'失败'}
    end
  end

  def order_list
    @orders=SscOrder.where(user:current_user).order(created_at: :desc)
  end


  private
  def order_params
    params.require(:order).permit!
  end
end