Deface::Override.new(
  :name => 'remove_sub_header',
  :virtual_path => 'spree/layouts/spree_application',
  :remove => "#subheader",
  :sequence => {:after => "add_subheader_to_layout"}
)
Deface::Override.new(
  :name => 'remove_footer',
  :virtual_path => 'spree/shared/_footer',
  :remove => '#footer'
)
# Deface::Override.new(
#   :name => 'sdfsdfsdf',
#   :virtual_path => 'spree/shared/_login',
#   :remove => '#password-credentials',
#   :sequence => 103
# )