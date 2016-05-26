Spree::OrdersController.class_eval do

  layout 'application'

  # Adds a new item to the order (creating a new order if none already exists)
  def populate
    populator = Spree::OrderPopulator.new(current_order(create_order_if_necessary: true), current_currency)
    if populator.populate(params[:variant_id], params[:quantity], params[:options])
      respond_with(@order) do |format|
        format.html { redirect_to cart_path }
      end
    else
      flash[:error] = populator.errors.full_messages.join(" ")
      redirect_back_or_default(request.referer)
    end
  end

  def update
    # render :text => order_params
    if @order.contents.update_cart(order_params)
      respond_with(@order) do |format|
        format.html do
          check_product
          if params.has_key?(:checkout)
            @order.next if @order.cart?
            redirect_to checkout_state_path(@order.checkout_steps.first)
          else
            redirect_to cart_path
          end
        end
      end
    else
      respond_with(@order)
    end
  end

  private
  def check_product
    # count = order_params["line_items_attributes"].count
    # for i in 0...count 
    #   line_item_id = order_params["line_items_attributes"][i.to_s]["id"] if order_params["line_items_attributes"][i.to_s]["quantity"] == 0
    # end
    # if line_item_id
    #   product_id = @order.line_items.find(line_item_id)

    #   variant_ids = @order.line_items.map(&:variant_id) & Spree::PromotionActionLineItem.all.map(&:variant_id)
    #   variant_id = variant_ids.first if variant_ids.present?
    #   @order.line_items.where(variant_id: variant_id).first.delete if variant_id
    # end

    variant_ids = @order.line_items.map(&:variant_id) & Spree::PromotionActionLineItem.all.map(&:variant_id)
    variant_id = variant_ids.first if variant_ids.present?
    products_order = @order.products.map(&:id)
    products_promotion = []
    Spree::Promotion.all.each do |promotion|
      products_promotion |= promotion.products.map(&:id)
    end
    if (products_order & products_promotion).blank?
      @order.line_items.where(variant_id: variant_id).first.delete if variant_id
    end
  end

end