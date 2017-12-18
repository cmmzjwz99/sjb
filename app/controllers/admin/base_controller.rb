class Admin::BaseController < ApplicationController
  before_action :login_required, except: [:login, :signup]

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

end
