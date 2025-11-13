class PagesController < ApplicationController
  def email_test
    BookingMailer.submission.deliver
    render inline: "Email sent!"
  end
end
