json.code @post.nil? ? 1 : 0
json.data do
  json.extract! @post, :id, :content, :user_id
  json.created_at @post.created_at.strftime('%Y-%m-%d %H:%M:%S')
  json.user_name @post.user.name
  json.user_img 'http://www.qizhenkeji.com/images/wap/user_head.png'
  json.images @post.get_img
  json.commends @post.post_comments.count
  json.likes @post.post_likes.count
  json.is_like (PostLike.where(user:current_user,post_id:@post.id).take ? true :false)
  json.result(@post.post_comments.order(created_at: :desc).limit(10)) do |ele|
    json.extract! ele, :id, :content, :user_id
    json.created_at ele.created_at.strftime('%Y-%m-%d %H:%M:%S')
  end
end
