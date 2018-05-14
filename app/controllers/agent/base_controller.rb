class Agent::BaseController < ApplicationController
  before_action :login_required, except: [:login, :signup]
  skip_before_action :verify_authenticity_token

  layout 'agent'
end
