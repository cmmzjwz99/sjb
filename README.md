== README


1. 重启后台服务器
目前我们使用的是nginx+passenger, 直接重启nginx即可重启rails服务器
cd /opt/nginx/sbin
./nginx -s reload
nginx的权限设置，要一直设置到根目录
chmod +x /root/work/server_yzd/config.ru
chmod a+w /root/work/server_yzd/log
chmod g+x,o+x /root/work/server_yzd
chmod g+x,o+x /root/work
chmod g+x,o+x /root

nginx日志
cd /opt/nginx/logs/
access.log是访问日志会记录所有的http request
error.log是错误日志，出错的时候可以查看一下
日志每天晚上都会自动备份和压缩


rails日志
cd /root/work/server4jing/log/ 
production.log是rails产生的日志，可以看到每个请求对应的controller，action，parameters等
logstash_production.log是格式化成json后的日志，主要是方便logstash分析


PS:
Product环境下依赖SECRET_KEY_BASE环境变量,目前我们直接写在.bashrc文件里，所以登录的时候已经自动export了, 如果没有的话，需要自己export一下:
cd ~/work/server4jing
export SECRET_KEY_BASE=$(rake secret)


rails unit test
rails will create db for test; and then use fixture/*.yml to reset datas.
so the columns in yml and schema.rb should be consist.
The same as the table name.

Rails开发:
设置环境变量 export RAILS_ENV=production
初始化db rake db:reset
锁死db:reset  配置/lib/tasks/db.rake

ImageMagick安装：
brew update
brew rm imagemagick
brew install imagemagick@6
brew link imagemagick@6 --force
bundle

gem install ruby-mcrypt -v '0.2.0' -- --with-mcrypt-dir=/usr/local/opt/mcrypt

# 本地测试
mysql： /usr/local/bin/mysql.server start
redis： redis-server
sidekiq:
sidekiqctl quiet tmp/pids/sidekiq.pid
sidekiqctl stop tmp/pids/sidekiq.pid
bundle exec sidekiq -d -e development
nginx: /opt/nginx/sbin/nginx  -s reload
 
# 服务器部署
## 步骤
sidekiq:
    sidekiqctl quiet tmp/pids/sidekiq.pid
            ps aux | grep sidekiq
        sidekiqctl stop tmp/pids/sidekiq.pid
    服务器代码更新
            bundle exec sidekiq -d -e production
        ps aux | grep sidekiq
nginx:
            /opt/nginx/sbin/nginx  -s reload

## 用户身份说明
1.admin
2.打款审核
3.录入员
5.催收人员
6.财务