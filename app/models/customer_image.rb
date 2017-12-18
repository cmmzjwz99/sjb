class CustomerImage< ActiveRecord::Base
  mount_uploader :img, ResourceUploader
  belongs_to :customer_message
end