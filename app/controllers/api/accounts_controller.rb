class Api::AccountsController < Api::BaseController

  # # before_action :login_required,:if => proc {|c|
  # #   c.action_name == 'generate_phone_code' && params[:phone].nil?
  # # }
  #
  # # &&
  #
  # before_action :login_required, except: [:login, :signup],:if => proc {|c|
  #   true
  #   # c.action_name == 'generate_phone_code' && params[:phone].nil?
  # }
  # before_action :verify_config
  # before_action :verify_users, only: [:login, :recover_password]
  # before_action :redirect_if_already_logged_in, only: :login

  # def index
  #   if User.count.zero?
  #     redirect_to signup_admin_accounts_path
  #   else
  #     redirect_to login_admin_accounts_path
  #   end
  # end
  def avatar
    @up = upload params[:user][:filename]
    @user = current_user
    if @up.present?
      @user.update(resource:@up)
    end
    respond_to do |format|
      format.json {render "user"}
    end
  end
  def info
    @user = current_user
    respond_to do |format|
      format.json {render "user"}
    end
  end

  def update_info
    @user = current_user
    @user.update_attributes(params.require(:user).permit!)

    respond_to do |format|
        if @user.save
          format.json { render "user" }
        else
          format.json { render json:{code:-1,msg:{error:"#{@user.errors.full_message[0]}"}}}
        end
    end
  end

  def modify_pwd
    case params[:category]
      when "0"
        puts "#{params[:current_password]}"
        puts "#{current_user.password}-----#{User.password_hash(params[:current_password])}"
        if current_user.password != User.password_hash(params[:current_password])
          return(render json:{code: 1,msg:{errors:"当前密码错误"}})
        end
        if current_user.update_password(params[:password])
          respond_to do |format|
            format.json {render json:{code:0,data:"更新成功"}}
          end
        end
      when "1"
        puts "#{params[:current_password]} ---#{params[:password]}"
        puts "#{current_user.verify_password}-----#{User.password_hash(params[:current_password])}"
        if current_user.verify_password != User.password_hash(params[:current_password])
          return(render json:{code: 1,msg:{errors:"当前密码错误"}})
        end
        if current_user.update_verify_password(params[:password])
          respond_to do |format|
            format.json {render json:{code:0,data:"更新成功"}}
          end
        end

    end

  end
  #
  # def modify_phone
  #
  # end

  def captcha
    render json:{code: 0,data: 3 > session[:times].to_i ? 0 : 1}
  end

  def login
    if params[:j_captcha]
      if !captcha_valid? params[:j_captcha]
        return(render json: { :code=>1,msg:{error:"无效验证码"}})
      end
    end

    self.current_user = User.authenticate(params[:user][:login], params[:user][:password])
    if logged_in?
      successful_login
      respond_to do |format|
        format.json { render 'user' }
      end
    else
      @login = params[:user][:login]
      if session[:times].nil?
        session[:times]=0;
      end
      session[:times]+=1
      return(render json: {:code=>1,msg:{error:"用户名或密码错误!"}}) #t('accounts.login.error'))
    end
  end

  def signup

    if params[:j_captcha]
      if !captcha_valid? params[:j_captcha]
        return(render json: {:code => 1, msg: {error: "无效验证码"}})
      end
    end

    if "#{params[:code]}" != "#{session[:code]}"
      return(render json: {:code => 1, msg: {error: "无效验证码"}})
    end

    @user = User.new((params[:user].permit! if params[:user]))

    # @user.generate_password!
    # session[:tmppass] = @user.password
    @user.name = @user.login
    if @user.save
      self.current_user = @user
      session[:user_id] = @user.id
      respond_to do |format|
        format.json {render 'user'}
      end
    else
      render json:{code: 1, msg:{error:"#{@user.errors.full_messages[0]}"}}
    end
  end

  def generate_phone_code

    return if params[:phone].nil? && !login_required

    session[:code] = code = rand(9999)

    user = current_user||
        User.new(id:1,phone:params[:phone])

    #result = Sm.new({content:"验证码: #{code}",user:user}).send_sms
    result=true

    respond_to do |format|
      format.json {
        if result
          render json: { code: 0,data:{msg:"发送成功"} }
        else
          render json: {code: 1,msg:{errors:"发送出错"}}
        end
      }
    end
  end

  def recover_password

    if "#{params[:code]}" != "#{session[:code]}"
      return(render json: { :code=>1,msg:{error:"无效验证码"}})
    end

    @user = User.default.find_by_phone(params[:phone])

    return(render json: {code: 1,msg:{errors:"此用户不存在"}}) if @user.nil?

    return(render json: {code: 1,msg:{errors:"两次输入密码不一致"}}) if params[:password] !=params[:confirm]

    respond_to do |format|
      if @user.update_password(params[:password])
        format.json {render 'user'}
      else
        format.json {render json:{code: 1,msg:{errors:"#{@user.errors.full_messages[0]}"}}}
      end

    end


    # return unless request.post?
    # @user = User.where('login = ? or email = ?', params[:user][:login], params[:user][:login]).first
    #
    # if @user
    #   @user.generate_password!
    #   @user.save
    #   flash[:notice] = t('accounts.recover_password.notice')
    #   redirect_to login_accounts_url
    # else
    #   flash[:error] = t('accounts.recover_password.error')
    # end
  end

  def logout
    flash[:notice] = t('accounts.logout.notice')
    current_user.forget_me
    self.current_user = nil
    session[:user_id] = nil
    cookies.delete :auth_token
    cookies.delete :publify_user_profile
    respond_to do |format|
        format.json { render json:{code: 0,data:"删除成功"} }
    end
  end

  # private
  #
  # def verify_users
  #   redirect_to(controller: 'accounts', action: 'signup') if User.count == 0
  #   true
  # end
  #
  # def verify_config
  #   redirect_to controller: 'setup', action: 'index' unless this_blog.configured?
  # end
  #
  # def redirect_if_already_logged_in
  #   if session[:user_id] && session[:user_id] == current_user.id
  #     redirect_back_or_default
  #   end
  # end

  def successful_login
    session[:user_id] = current_user.id
    @user = current_user
    # if params[:remember_me] == '1'
      current_user.remember_me
    # unless current_user.remember_token?
      cookies[:auth_token] = {
        value: current_user.remember_token,
        expires: current_user.remember_token_expires_at,
        httponly: true # Help prevent auth_token theft.
      }
    # end
    # add_to_cookies(:publify_user_profile, current_user.profile_label, '/')

    current_user.update_connection_time
    flash[:success] = t('accounts.login.success')
    # redirect_back_or_default
  end

  def redirect_back_or_default
    redirect_to(session[:return_to] || { controller: 'admin/dashboard', action: 'index' })
    session[:return_to] = nil
  end

end
