if Rails.env.production? && ENV.fetch('INTERCEPT_EMAILS', "true") == "true"
  interceptor = MailInterceptor::Interceptor.new(
    env: OpenStruct.new(intercept?: true),
    forward_emails_to: ENV.fetch('SEND_INTERCEPTED_EMAILS_TO')
  )
  ActionMailer::Base.register_interceptor(interceptor)
end
