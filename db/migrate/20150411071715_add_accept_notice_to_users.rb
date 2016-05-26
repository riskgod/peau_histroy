class AddAcceptNoticeToUsers < ActiveRecord::Migration
  def change
    add_column :spree_users, :accept_notice, :boolean, default: true
  end
end
