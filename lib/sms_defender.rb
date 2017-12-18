require 'rack/throttle'

module SmsDefender
  def initialize(app, options = {})
    options.merge!({
                       cache: $redis,
                       key_prefix: self.class.name,
                       code: 200,
                       type: 'application/json; charset=utf-8',
                       message: error_message
                   })
    @app, @options = app, options
  end

  def allowed?(request)
    path_info = Rails.application.routes.recognize_path request.url rescue path_info = {}
    if path_info[:controller] == "api/accounts" and path_info[:action] == "generate_phone_code" \
      and (request['phone'].present? or request.cookies['auth_token'].present?)
      super
    else
      true
    end
  end

  def client_identifier(request)
    if request['phone'].present?
      request['phone']
    else
      user = User.select('login').find_by_remember_token(request.cookies['auth_token'])
      if user.present?
        user.login
      else
        request.cookies['auth_token']
      end
    end
  end
end

class SmsDailyDefender < Rack::Throttle::Daily
  include SmsDefender

  def error_message
    '{"code": 1, "msg": { "error": "您今天的短信验证码发送量已经达到上限,请明日再试" }}'
  end
end


class SmsHourlyDefender < Rack::Throttle::Hourly
  include SmsDefender

  def error_message
    '{"code": 1, "msg": { "error": "您的短信验证码发送量已经达到上限,请稍后重试" }}'
  end
end

class SmsIPDefender < SmsDailyDefender
  def client_identifier(request)
    request.ip
  end
end