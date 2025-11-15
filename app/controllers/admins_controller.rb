class AdminsController < ApplicationController
  before_action :enforce_auth
  def email_test
    BookingMailer.submission.deliver_now
    render inline: "Email sent!"
  end

  private
  def enforce_auth
    return if authenticate_with_http_basic { |u, p|
      if Rails.env.local?
        u == 'admin' && p == 'password'
      else
        u == ENV.fetch("ADMIN_USER", "") && p == ENV.fetch("ADMIN_PASS", "")
      end
    }
    request_http_basic_authentication
  end
end
