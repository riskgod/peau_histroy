Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  get "/alipay_pay" => "alipay#pay"
  post "/alipay_notify" => "alipay#notify"
end