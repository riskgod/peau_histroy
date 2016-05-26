Spree::BaseHelper.module_eval do
 def link_to_cart
    count = cart_item_num
    (link_to image_tag('cart.png'), spree.cart_path, class: 'cart_link') + %{<span class='cart_num'>#{count}</span>}.html_safe
  end

  def cart_item_num
    if simple_current_order.nil? or simple_current_order.item_count.zero?
      count = "#{Spree.t(:empty)}"
    else
      count = "#{simple_current_order.item_count}"
    end
    return count
  end

  def display_price(item)
    number_to_currency(item.price, format: "￥%n", precision: 2)
  end
end
