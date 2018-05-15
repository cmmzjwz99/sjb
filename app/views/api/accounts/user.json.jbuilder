json.code @user.nil? ? 1 : 0
json.data do
  json.extract! @user, :id, :login,:name

end
