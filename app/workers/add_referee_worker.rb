class AddRefereeWorker
  include Sidekiq::Worker
  def perform
    User.where(user_id:[0..3739]).each do |ele|
      SignupRefereeWorker.perform_async(ele.id)
    end
    #OddsWorker.perform_in(1.minutes)
  end
end