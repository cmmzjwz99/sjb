class ApplicationController < ActionController::Base
  # reset captcha code after each request for security
  #after_filter :reset_last_captcha_code!

  include ::LoginSystem

  # before_action :login_required, except: [:login, :signup]
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # $.ajaxSetup({
  #                 headers: {
  #                     'X-XSRF-TOKEN': $cookies['XSRF-TOKEN'],
  #                     'X-CSRF-Token': $cookies['XSRF-TOKEN']
  #                 }
  #             });

  # protect_from_forgery
  # before_filter :authenticate_user!
  # def after_set_user
  #   cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  #   puts("set_csrf_cookie_for_ng #{form_authenticity_token}")
  # end
  # class << self
  #   unless self.respond_to? :template_root
  #     def template_root
  #       ActionController::Base.view_paths.last
  #     end
  #   end
  # end

  def add_to_cookies(name, value, path = nil, _expires = nil)
    cookies[name] = { value: value, path: path || "/#{controller_name}", expires: 6.weeks.from_now }
  end
end
