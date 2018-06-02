class Api::SettingsController < Api::BaseController
  def title
    title=Setting.where(category:'title')[0] || Setting.new()
    render json:{code:0,data:title.val}
  end

  def customer
    customer=Setting.where(category:'customer')[0] || Setting.new()
    render json:{code:0,data:customer.val}
  end
end