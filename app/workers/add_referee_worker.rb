class AddRefereeWorker
  include Sidekiq::Worker
  def perform
    User.where({}).each do |ele|
      SignupRefereeWorker.perform_async(ele.id)
    end
    #OddsWorker.perform_in(1.minutes)
  end
end