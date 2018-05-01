class RenameColumnMessengerIdFromUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :messenger_id, :messenger_uid
  end
end
