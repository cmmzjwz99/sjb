class Api::PostsController < Api::BaseController
  def index
    sql=' 1=1 '
    if params[:type].present? and params[:type]=='top'
      sql+=" and id > #{params[:id]}"
    elsif params[:type].present? and params[:type]=='bottom'
      sql+=" and id < #{params[:id]}"
    end
    @posts=Post.where(sql).order(created_at: :desc).limit(10)
  end

  def detail
    @post=Post.find(params[:id])
  end

  def write
    @post=Post.new(params.require(:post).permit!)
    @post.user=current_user
    @post.save

  end

  def reply
    comment=PostComment.new(params.require(:comment).permit!)
    comment.user=current_user
    comment.save
    render json:{code:0 , msg:'dsf'}
  end

  def like
    like=PostLike.where(user:current_user,post_id:params[:post_id])
    if like.count>0
      like.destroy_all
    else
      PostLike.new(user:current_user,post_id:params[:post_id]).save
    end
    render json:{code:0 , msg:'成功'}
  end

  def delete

  end

  def img_upload
    postimg=PostImg.new()
    postimg.image_url=params[:img]
    postimg.save
    return(render json:{code:0 , data:{id:postimg.id,url:postimg.image_url.url}})
  end

end