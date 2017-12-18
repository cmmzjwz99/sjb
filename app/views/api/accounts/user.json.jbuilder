json.code @user.nil? ? 1 : 0
json.data do
  json.extract! @user, :id, :login,:phone,:birthday,:location,:slogan,:company,:job,:name,:email,:sex,:real_name,:idcard,:referee

  #if @user.resource.present?
  #  json.avatar image_url(@user.resource.upload.url)
  #end
end
