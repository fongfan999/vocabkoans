class AddSentAtToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :sent_at, :datetime
  end
end
