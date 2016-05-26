module Spree
  module ContactUs
    class Contact

      include ActiveModel::Conversion
      include ActiveModel::Validations

      attr_accessor :first_name, :last_name, :city, :state, :address, :country, :address2, :mobile, :zipcode, :phone, :email, :message, :subject, :zhiwei, :gender, :id_member, :state_id, :country_id

      EMAIL_REGEX = /\A
        [^\s@]+ # non-at-sign characters, at least one
          @     # at-sign
        [^\s.@] # non-at-sign and non-period character
        [^\s@]* # 0 or more non-at-sign characters, accepts any number of periods
         \.     # period
        [^\s@]* # 0 or more non-at-sign characters, accepts any number of periods
        [^\s.@] # non-at-sign and non-period character
      \z/x

      # validates :email,   :format => { :with => EMAIL_REGEX },
      #                     :presence => true
      # validates :message, :presence => true
      # validates :subject, :presence => {:if => Proc.new{SpreeContactUs.require_subject}}

      def initialize(attributes = {})
        [:first_name, :last_name, :city, :state, :address, :country, :address2, :mobile, :zipcode, :phone, :email, :message, :subject, :zhiwei, :gender, :id_member, :state_id, :country_id].each do |attribute|
          self.send("#{attribute}=", attributes[attribute]) if attributes and attributes.has_key?(attribute)
        end
      end

      def save
        if self.valid?
          Spree::ContactUs::ContactMailer.contact_email(self).deliver
          return true
        end
        return false
      end

      def persisted?
        false
      end

    end
  end
end
