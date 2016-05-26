# This migration comes from spree_gift_cards (originally 20150118141932)
class CreateSpreeGiftCards < ActiveRecord::Migration
  def change
    create_table :spree_gift_cards do |t|
      t.string :code
      t.decimal :amount, :precision => 8, :scale => 2, :default => 0.0, :null => false
      t.string :reason
      t.references :user
      t.timestamps
    end
  end
end
