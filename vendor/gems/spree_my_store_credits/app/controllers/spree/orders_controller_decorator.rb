module Spree
  OrdersController.class_eval do
    before_action :edit_do_something
    private
    def edit_do_something
      @order.do_something(0) if @order
    end
  end
end