class Api::QuizController < Api::BaseController
  def list
    @matchs=Match.online.where({}).order(:start_time)
  end

  def history

  end

  def buy
    @order= Order.new(order_params)
    if @order.game.match.status!=1
      render json:{code:2,msg:'当前不可押注'}
      return
    end
    @order.user_id=current_user.id
    if @order.user.points<@order.point
      render json:{code:1,msg:'金币不足'}
      return
    end
    case @order.team
      when 1
        odds=@order.game.odds1
      when 2
        odds=@order.game.odds2
      when 3
        odds=@order.game.odds3
    end
    @order.get_point=@order.point*odds
    @order.odds=odds
    if @order.save
      render json:{code:0,msg:'成功'}
    else
      render json:{code:1,msg:'失败'}
    end
  end

  def odds
    @games=Game.where(match: Match.where(status:1))
  end

  def my_order
    @orders=Order.where({user:current_user}).order(created_at: :desc)
  end


  private
  def order_params
    params.require(:order).permit!
  end
end