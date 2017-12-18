CarrierWave.configure do |config|
  config.storage           = :aliyun
  config.aliyun_access_id  = "LTAIwwlAixUeNNeY"
  config.aliyun_access_key = 'dycpYxJ9OKZ6RcagNjCOW6yv3MBMHc'
  # 你需要在 Aliyum OSS 上面提前创建一个 Bucket
  # lianghaodai01用于生产环境,lianghaodai02用于开发和测试环境
  config.aliyun_bucket     = "yunzhidai"
  # 是否使用内部连接，true - 使用 Aliyun 主机内部局域网的方式访问  false - 外部网络访问
  config.aliyun_internal   = true
  # 配置存储的地区数据中心，默认: cn-hangzhou
  config.aliyun_area     = "cn-shanghai"
  # 使用自定义域名，设定此项，carrierwave 返回的 URL 将会用自定义域名
  # 自定于域名请 CNAME 到 you_bucket_name.oss-cn-hangzhou.aliyuncs.com (you_bucket_name 是你的 bucket 的名称)
  # config.aliyun_host       = "http://foo.bar.com"
  # 配置缩略图 Host，默认 #{aliyun_bucket}.img-#{aliyun_area}.aliyuncs.com
  # config.aliyun_img_host   = "http://you_bucket_name.img-cn-hangzhou.aliyuncs.com"
  # Bucket 为私有读取请设置 true，默认 false，以便得到的 URL 是能带有 private 空间访问权限的逻辑
  # config.aliyun_private_read = false
end