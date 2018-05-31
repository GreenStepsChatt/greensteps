class TermsMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.terms_mailer.updated_terms_email.subject
  #
  def updated_terms_email(user)
    attachments['terms.pdf'] =
      File.read(Rails.root.join('public', 'documents', 'terms.pdf'))
    mail to: user.email, subject: "We've updated our terms and conditions"
  end
end
