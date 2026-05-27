class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("MAILER_FROM", ENV.fetch("SMTP_USERNAME"))
  layout "mailer"
end