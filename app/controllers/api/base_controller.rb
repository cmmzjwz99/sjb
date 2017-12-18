class Api::BaseController < ApplicationController
  before_action :login_required, except: [:login, :signup,:captcha,:generate_phone_code,:recover_password]

  skip_before_action :verify_authenticity_token

  def upload(file)
    # if !params[:adv].blank?
    #file = params[:wallpaper][:filename]
    if file
      mime = if file.content_type
               file.content_type.chomp
             else
               'text/plain'
             end
      flash[:success] = I18n.t('admin.resources.upload.success')
      @up = Resource.create(upload: file, mime: mime, created_at: Time.now)
    else
      nil
    end
  end

  # override Logstasher method to append response info in log
  def append_info_to_payload(payload)
    begin
      super
      LogStasher.store[:response] = response.body.to_s
    rescue
      # do nothing
    end
  end

end