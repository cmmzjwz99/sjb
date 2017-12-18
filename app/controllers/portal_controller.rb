# coding: utf-8
class PortalController <  ApplicationController
  layout :false

  def index
    redirect_to login_admin_accounts_path
  end
end
