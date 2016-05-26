module Spree
  class GiftCard < ActiveRecord::Base
  	belongs_to :user
    # attr_accessible :amount, :code, :reason, :user_id
    validates :code,               presence: true, uniqueness: true
    before_validation :generate_code, on: :create
    def generate_code
      until self.code.present? && self.class.where(code: self.code).count == 0
        # self.code = Digest::SHA1.hexdigest([Time.now, rand].join)
        self.code = SecureRandom.hex 5
      end
    end
  end
end