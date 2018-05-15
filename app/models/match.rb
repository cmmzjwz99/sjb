class Match < ActiveRecord::Base
  self.table_name='matchs'
  has_many :games
end