class BookingMailer < ApplicationMailer
  def submission
    mail(to: "ppi@carguppy.com", subject: "Booking Submission")
  end
end
