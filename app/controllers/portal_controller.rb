# coding: utf-8
class PortalController <  ApplicationController
  layout :false

  def index
    redirect_to "http://a.app.qq.com/o/simple.jsp?pkgname=net.amaze.program"
  end
end
