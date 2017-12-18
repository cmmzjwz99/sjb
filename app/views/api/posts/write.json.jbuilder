json.code @post.nil? ? 1 : 0
json.data do
  json.extract! @post, :id, :title,:content

  #if @user.resource.present?
  #  json.avatar image_url(@user.resource.upload.url)
  #end
end
