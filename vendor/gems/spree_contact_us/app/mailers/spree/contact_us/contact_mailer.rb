class Spree::ContactUs::ContactMailer < Spree::BaseMailer
  layout false
  def contact_email(contact)
    @contact = contact

    mail :from     => Settings.email.from,
         :subject  => Settings.email.contact_title,
         :to       => Settings.email.cusotmer,
         :bcc       => Settings.email.admin
  end
end
