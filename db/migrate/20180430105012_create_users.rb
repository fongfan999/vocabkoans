class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :messenger_id
      t.integer :words_of_the_day, default: 0

      t.timestamps
    end
    add_index :users, :messenger_id
  end
end
