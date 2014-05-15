

class SiteMailer < ActionMailer::Base
  default from: ENV['EMAIL_FROM_ADDRESS']
  def status_email(email, subject, body)
    mail(to: email, subject: 'TESTING 1-2-3')
  end
end
