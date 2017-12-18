namespace :ws do
  desc "NO.1 : my first rake task"
  task :start do

    CHANNEL        = "chat-redis"

    APP_KEY = '3e8381ad9dcd9b030fea10ff'
    MASTER_SECRET = '97126ca80e68d6c0a23b5eca'

    # CHANNELMYSQL        = "chat-mysql"

    @clients = []
    @phone = ""
    PRODUCT = (Rails.env == "production")

    uri = URI.parse("redis://localhost:6379")
    @redis = Redis.new(host: uri.host, port: uri.port, password: uri.password)

    @jpush = JPush::JPushClient.new(APP_KEY, MASTER_SECRET);

    Thread.new do
      redis_sub = Redis.new(host: uri.host, port: uri.port, password: uri.password)
      redis_sub.subscribe(CHANNEL) do |on|
        on.message do |channel, msg|
          @clients.each {|ws| ws.send(msg) }
        end
      end

    end

    EM.epoll
    EM.run do
      trap("TERM") { stop }
      trap("INT")  { stop }
      WebSocket::EventMachine::Server.start(:host => "0.0.0.0", :port => 9001) do |ws|

        phone = ""

        ws.onopen do
          @clients << ws
        end

        ws.onmessage do |msg, type|

          phone = JSON.parse(msg)["phone"]

          jpush(8080,phone)
          # ws.send msg, :type => type
          # @redis.publish(CHANNEL, sanitize(event.data))
        end
        ws.onclose do |msg, type|
          jpush('8001',phone)
          @clients.delete(ws)
        end
      end

      puts "Server started at port 9001"

      def jpush(code = 8080,tag)
        puts "#{tag}----"
        begin
          payload =JPush::PushPayload.build(platform: JPush::Platform.all,
                                            audience: JPush::Audience.build(tag: Array["#{tag}"] ),
                                            message: JPush::Message.new(msg_content:code),#notification: JPush::Notification.new(alert: "this is test")
                                            options:JPush::Options.build(
                                                :time_to_live=> 86400,
                                                :apns_production=> PRODUCT)
          )
          @result = @jpush.sendPush(payload)
        rescue JPush::ApiConnectionException => e
          puts "#{e}"
        end
      end

      def stop
        puts "Terminating WebSocket Server"
        EventMachine.stop
      end
    end
  end

  # def sanitize(message)
  #   json = JSON.parse(message)
  #   json.each {|key, value| json[key] = ERB::Util.html_escape(value) }
  #   JSON.generate(json)
  # end
end