if ENV.fetch('INTERCEPT_EMAILS', true)
  interceptor = MailInterceptor::Interceptor.new(
    forward_emails_to: ENV.fetch('SEND_INTERCEPTED_EMAILS_TO')
  )
  ActionMailer::Base.register_interceptor(interceptor)
end
