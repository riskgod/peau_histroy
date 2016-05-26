Deface::Override.new(
  :name => 'remove_home_link_and_shop_link',
  :virtual_path => 'spree/shared/_main_nav_bar',
  :remove => "#main-nav-bar",
  :sequence => 101
)