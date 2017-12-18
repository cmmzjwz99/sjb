json.code @posts.nil? ? 1 : 0
json.data(@posts) do |adv|
  json.extract! adv, :id, :content, :user_id
  json.created_at adv.created_at.strftime('%Y-%m-%d %H:%M:%S')
  json.user_name adv.user.name
  json.user_img 'http://www.qizhenkeji.com/images/wap/user_head.png'
  json.images adv.get_img
  json.commends adv.post_comments.count
  json.likes adv.post_likes.count
  json.is_like (PostLike.where(user:current_user,post_id:adv.id).take ? true :false)
  if(adv.parent_id.present?)
    parent=Post.find(adv.parent_id)
    json.parent do
      json.extract! parent, :id,:content
      json.images parent.get_img
    end
  end
end