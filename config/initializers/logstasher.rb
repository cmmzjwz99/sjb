if LogStasher.enabled?
  LogStasher.add_custom_fields do |fields|
    # This block is run in application_controller context,
    # so you have access to all controller methods

    fields[:params] = request.filtered_parameters

    begin
      if current_user
        fields[:user] = current_user.login
      end

      if request.user_agent
        fields[:agent] = Utf8Utils.to_utf8(request.user_agent)
      end

      fields[:node] = ENV['NODE']
    rescue Exception => e
      logger.error(e.message)
    end
  end
end