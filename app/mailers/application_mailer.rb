class ApplicationMailer < ActionMailer::Base
  default from: "donotreply@jungle.com"
  layout 'mailer'
end
