class ApplicationMailer < ActionMailer::Base
  default from: ENV["EXAMPLE_NOREPLY"]
  layout "mailer"
end
