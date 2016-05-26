module ApplicationHelper
  def link_to_cart_with_icon
    if simple_current_order.nil? or simple_current_order.item_count.zero?
      count = "#{Spree.t(:empty)}"
    else
      count = "#{simple_current_order.item_count}"
    end
    link_to spree.cart_path, class: "dropdown-toggle", "data-toggle" => "dropdown", role: "button", "aria-expanded" => "true" do
      "<span class=\"glyphicon glyphicon-shopping-cart\" aria-hidden=\"true\"></span> (#{count})".html_safe
    end
  end

  def alert_name(name)
    case name
    when "notice"
      "success"
    when "alert"
      "danger"
    when "error"
      "warning"
    else
      "info"
    end
  end

  def bg_picture(params)
    case params["taxon_id"]
    when "5"
      asset_url('detail_bg2.jpg')
    when "7"
      asset_url('detail_bg2.jpg')
    when "8"
      asset_url('detail_bg2.jpg')
    when "14"
      asset_url('detail_bg.jpg')
    when "17"
      asset_url('detail_bg2.jpg')
    when "23"
      asset_url('christmas04.jpg')
    else
      asset_url('christmas04.jpg')
    end
  end
end
