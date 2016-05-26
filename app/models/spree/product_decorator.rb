module Spree
  Product.class_eval do
    def normalize_friendly_id(input)
      input.to_s.to_slug.normalize.to_s
    end

    def self.top(product)
      taxons = product.taxons
      products = []
      taxons.each do |taxon|
        products << taxon.products
      end
      products.flatten.reject { |p| p == product or p.available_on > Time.now }
    end
  end
end
