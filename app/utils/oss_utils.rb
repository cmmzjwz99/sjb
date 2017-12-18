require 'aliyun/oss'
module OSSUtils
  def self.shanghai_client(bucket_name)
    client = Aliyun::Oss::Client.new('kUazWeDwZ0rANDzb',
                                     'Q7xjbppVorwaQZPkN8CpJPUAyZgoMy',
                                     host: 'oss-cn-shanghai.aliyuncs.com',
                                     bucket: bucket_name)
  end

  def self.hangzhou_client(bucket_name)
    client = Aliyun::Oss::Client.new('kUazWeDwZ0rANDzb',
                                     'Q7xjbppVorwaQZPkN8CpJPUAyZgoMy',
                                     host: 'oss-cn-hangzhou.aliyuncs.com',
                                     bucket: bucket_name)
  end
end