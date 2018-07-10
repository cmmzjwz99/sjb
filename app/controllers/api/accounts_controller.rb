class Api::AccountsController < Api::BaseController
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
          SignupRefereeWorker.perform_async(@user.id)
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

  def captcha
    render json:{code: 0,data: 3 > session[:times].to_i ? 0 : 1}
  end

  def login
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
    @user = User.new((params[:user].permit! if params[:user]))

    @user.referee=(@user.referee.to_i== 0 ? nil : @user.referee.to_i)
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

  def recover_password

    @user = current_user

    return(render json: {code: 1,msg:"此用户不存在"}) if @user.nil?

    return(render json: {code: 1,msg:"两次输入密码不一致"}) if params[:password] !=params[:confirm]

    respond_to do |format|
      if @user.update_password(params[:password])
        format.json {render 'user'}
      else
        format.json {render json:{code: 1,msg:"#{@user.errors.full_messages[0]}"}}
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
    respond_to do |format|
        format.json { render json:{code: 0,data:"删除成功"} }
    end
  end

  def successful_login
    session[:user_id] = current_user.id
    @user = current_user
    current_user.remember_me
    cookies[:auth_token] = {
        value: current_user.remember_token,
        expires: current_user.remember_token_expires_at,
        httponly: true # Help prevent auth_token theft.
    }
    current_user.update_connection_time
    flash[:success] = t('accounts.login.success')
  end
end
