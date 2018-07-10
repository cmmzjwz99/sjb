class SignupRefereeWorker
  include Sidekiq::Worker
  #用户关系树
  def perform id
    user=User.find(id)
    a=1
    while user.referee.present? do
      user=User.find(user.referee)
      UserReferee.create({user:id,referee:user.id,level:a})
      a=a+1
    end
  end
end