
Deface::Override.new(virtual_path: 'spree/admin/shared/_tabs',
  name: 'add_gift_cards_tab',
  insert_after: "erb[silent]:contains('if can? :admin, Spree::Promotion')",
  text: "
    <%= tab :gift_cards, value: 'aaa', icon: 'envelope', url: spree.admin_gift_cards_path %>
  "
)