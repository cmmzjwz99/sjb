module LoginSystem
  protected

    def logged_in?
      current_user != false
    end

    def current_user
      @current_user ||= (login_from_session || login_from_basic_auth || login_from_cookie || false)
    end

    def current_user=(new_user)
      session[:user] = (new_user.nil? || new_user.is_a?(Symbol)) ? nil : new_user.id
      @current_user = new_user
    end

    # If the current actions are in our access rule will be verifyed
    def allowed?
      namespace = get_namespace
      (namespace == Profile::API) || (@current_user.profile.label == namespace)
      # AccessControl.allowed_controllers(current_user.profile.label, current_user.profile.modules).include?(params[:controller])
    end

    def authorized?
      logged_in? && allowed?
    end

    def login_required
      authorized? || access_denied
    end

    def access_denied
      respond_to do |format|
        format.html do
          # store_location
          session[:return_to] = request.fullpath

          namespace = get_namespace

          if logged_in?
            flash[:error] = "对不起,您没有权限访问该页面!"
            redirect_to controller: "#{namespace}/accounts", action: 'login'
          elsif User.first
            redirect_to controller: "#{namespace}/accounts", action: 'login'
            # redirect_to login_admin_accounts_path
          else
            redirect_to controller: "#{namespace}/accounts", action: 'signup'
          end
        end
        format.xml do
          headers['Status'] = 'Unauthorized'
          headers['WWW-Authenticate'] = %(Basic realm="Web Password")
          render text: "Could't authenticate you", status: '401 Unauthorized'
        end
        format.json do
          render json:{code:1000,msg:{errors:"用户未登录"}}
        end
      end
      false
    end

    def store_location
      session[:return_to] = request.fullpath
    end

    def self.included(base)
      base.send :helper_method, :current_user, :logged_in?
    end

    def login_from_session
      self.current_user = User.find_by_id(session[:user]) if session[:user]
    end

    def login_from_basic_auth
      email, passwd = get_auth_data
      self.current_user = User.authenticate(email, passwd) if email && passwd
    end

    # Called from #current_user.  Finaly, attempt to login by an expiring token in the cookie.
    def login_from_cookie
      cookies[:auth_token] && User.find_by_remember_token(cookies[:auth_token])
      # puts "#{cookies[:auth_token]}---cookie----"
      # user = cookies[:auth_token] && User.find_by_remember_token(cookies[:auth_token])
      # if user && user.remember_token
      #
      #   user.remember_me
      #   puts "#{user.remember_token}---cookie----#{user.remember_token_expires_at}----"
      #
      #   cookies[:auth_token] = { value: user.remember_token, expires: user.remember_token_expires_at, httponly: true  }
      #
      #   puts "#{cookies[:auth_token]}----cookie---"
      #   self.current_user = user
      # end
      # user
    end

  private

    @@http_auth_headers = %w(X-HTTP_AUTHORIZATION HTTP_AUTHORIZATION Authorization)
    # gets BASIC auth info
    def get_auth_data
      auth_key = @@http_auth_headers.find { |h| request.env.key?(h) }
      auth_data = request.env[auth_key].to_s.split unless auth_key.blank?
      auth_data && auth_data[0] == 'Basic' ? Base64.decode64(auth_data[1]).split(':')[0..1] : [nil, nil]
    end

    def get_namespace
      case
        when request.fullpath.start_with?("/admin")
          return Profile::ADMIN
        when request.fullpath.start_with?("/agent")
          return Profile::AGENT
        else
          return Profile::API
      end
    end
end
