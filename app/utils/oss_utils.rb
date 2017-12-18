require 'aliyun/oss'
module OSSUtils
  def self.shanghai_client(bucket_name)
    client = Aliyun::Oss::Client.new('LTAIwwlAixUeNNeY',
                                     'dycpYxJ9OKZ6RcagNjCOW6yv3MBMHc',
                                     host: 'oss-cn-shanghai.aliyuncs.com',
                                     bucket: bucket_name)
  end
end