class Admin::AccountsController < Admin::BaseController
  # before_action :verify_config
  # before_action :verify_users, only: [:login, :recover_password]
  # before_action :redirect_if_already_logged_in, only: :login


  layout 'accounts' ,except: [:recover_password]


  def index
    render text: User.password_hash('lhd2016')
    # @param_pay = Mpay.new.pay
    # render text: digitUppercase(100)
  end

  def login
    return unless request.post?
    self.current_user = User.admin.authenticate(params[:user][:login], params[:user][:password])
    if logged_in?
      successful_login
      render json:{code:0}
    else
      flash[:error] = "用户名或密码错误!"
      #t('accounts.login.error')
      @login = params[:user][:login]
      render json:{code:1,msg:"用户名或密码错误!"}
    end
  end

  def signup

    @user = User.new((params[:user].permit! if params[:user]))

    return unless request.post?

    # @user.generate_password!
    session[:tmppass] = @user.password
    @user.name = @user.login
    if @user.save
      self.current_user = @user
      session[:user_id] = @user.id

      redirect_to login_admin_accounts_path

      return
    end
  end

  def recover_password
    if request.post?
      if current_user.password != User.password_hash(params[:current_password])
        render json: {code:1,msg:'原密码错误'}
        return
      end

      if current_user.update_password(params[:password])
        render json: {code:0,msg:'修改成功'}
        return
      end
    end
  end

  def logout
    flash[:notice] = t('accounts.logout.notice')
    current_user.forget_me
    self.current_user = nil
    session[:user_id] = nil
    cookies.delete :auth_token
    cookies.delete :publify_user_profile
    redirect_to login_admin_accounts_path
  end

  def successful_login
    session[:user_id] = current_user.id
    if params[:remember_me] == '1'
      current_user.remember_me unless current_user.remember_token?
      cookies[:auth_token] = {
          value: current_user.remember_token,
          expires: current_user.remember_token_expires_at,
          httponly: true # Help prevent auth_token theft.
      }
    end
    # add_to_cookies(:publify_user_profile, current_user.profile_label, '/')

    current_user.update_connection_time
    #t('accounts.login.success')
    redirect_back_or_default
  end

  def redirect_back_or_default
    #redirect_to(session[:return_to] || { controller: 'admin/dashboard', action: 'index' })
    #session[:return_to] = nil
  end
end