class ChangeReadAtFromSubscriptionsToUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :subscriptions, :read_at, :datetime
    add_column :users, :last_read_vocabulary_at, :datetime
  end
end
