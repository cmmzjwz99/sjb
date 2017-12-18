class LoanImage < ActiveRecord::Base
  mount_uploader :img, ResourceUploader
  belongs_to :loan
end