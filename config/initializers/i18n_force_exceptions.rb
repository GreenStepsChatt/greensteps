if Rails.env.test?
  module I18n
    class ForceMissingTranslationsHandler < ExceptionHandler
      def call(exception, locale, key, options)
        raise exception.to_exception
      end
    end
  end

  I18n.exception_handler = I18n::ForceMissingTranslationsHandler.new
end
