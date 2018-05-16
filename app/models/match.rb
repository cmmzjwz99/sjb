class Match < ActiveRecord::Base
  self.table_name='matchs'
  has_many :games

  #status 0未开始 1可竞猜 2进行中 3已结束
end