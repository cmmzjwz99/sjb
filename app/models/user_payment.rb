class UserPayment < ActiveRecord::Base
  belongs_to :user

  mount_uploader :alipay_qr, ResourceUploader
  mount_uploader :wechat_qr, ResourceUploader
end