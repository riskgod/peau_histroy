module Spree
  class AlipayController < StoreController
    skip_before_filter :verify_authenticity_token, only: [:notify]
    # ssl_allowed

    # 标准双接口
    def pay
      @order = current_order || raise(ActiveRecord::RecordNotFound)
      @payment = @order.payments.create(amount: @order.amount, payment_method_id: params[:payment_method_id])
      if @payment
        @payment.started_processing!
        pay_url = payment_method.pay options
        redirect_to pay_url
      else
        redirect_to :root, notice: Spree.t(:no_payment_found)
      end
    end

    def notify
      notify_params = params.except(*request.path_parameters.keys)
      logger.info notify_params
      if Alipay::Notify.verify?(notify_params) and notify_params[:trade_status] == 'TRADE_SUCCESS'
        out_trade_no = notify_params[:out_trade_no]
        payment = Spree::Payment.find_by(identifier: out_trade_no) || raise(ActiveRecord::RecordNotFound)
        unless payment.completed?
          payment.complete!
          payment.order.update_attributes(state: "complete")
          payment.order.finalize!
        end
        render text: "success"
      else
        render text: "fail"
      end
    end

    private

    def payment_method
      @payment_method ||= Spree::PaymentMethod.find(params[:payment_method_id])
      @payment_method
    end

    def provider
      @payment_method.provider
    end

    def options
      {
        :out_trade_no      => @payment.identifier,
        :subject           => %{订单编号: #{@payment.identifier}},
        :logistics_type    => 'EMS',
        :logistics_fee     => @order.shipments.to_a.sum(&:cost),
        :logistics_payment => 'BUYER_PAY',
        :price             => @order.total,
        :quantity          => 1,
        :discount          => 0.0,
        :return_url        => spree.order_url(@order),
        :notify_url        => alipay_notify_url,
        :receive_name      => receive_name(@order),
        :receive_address   => receive_address(@order),
        :receive_zip       => (@order.billing_address.zipcode.presence || "10000" rescue "10000") ,
        :receive_phone     => (@order.billing_address.phone rescue "11112222333")
      }
    end

    def receive_name(order)
      [order.billing_address.lastname, order.billing_address.firstname].join(" ")
    ensure
      Spree.t("alipay.invalid_name")
    end

    def receive_address(order)
      [order.billing_address.country, order.billing_address.state, order.billing_address.city, order.billing_address.address1, order.billing_address.address2].join(" ")
    ensure
      Spree.t("alipay.invalid_address")
    end
  end
end
