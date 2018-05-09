class AddReadAtToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :read_at, :datetime
  end
end
