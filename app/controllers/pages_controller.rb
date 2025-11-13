class PagesController < ApplicationController
  def email_test
    BookingMailer.submission.deliver_now
    render inline: "Email sent!"
  end
end
