class EmailController < ApplicationController

  def about
  end

  def email

    email = params[:email]
    SiteMailer.status_email(email[:email], email[:subject], email[:body]).deliver
  render nothing: true, status: 200

    # put logic for sending an email

   
    # TODO: send the email here.
  end
end

