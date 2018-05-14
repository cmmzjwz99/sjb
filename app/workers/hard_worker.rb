class HardWorker
  include Sidekiq::Worker

  def perform(*args)
    # Do something
    p 'HardWorker'
    Rails.cache.write('worker', 'HardWorker')
  end
end
