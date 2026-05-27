class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("MAILER_FROM", "no-reply@chatmaster-mbie.onrender.com")
  layout "mailer"
end