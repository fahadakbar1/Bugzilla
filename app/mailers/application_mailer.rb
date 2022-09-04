# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'fahad.akbar@devsinc.com'
  layout 'mailer'
end
