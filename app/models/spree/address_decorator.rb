module Spree
  Address.class_eval do

    def require_phone?
      false
    end

    def require_zipcode?
      false
    end

  end

end
