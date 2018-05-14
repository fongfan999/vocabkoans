class AddVocabularySenseIndexToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :vocabulary_sense_index, :integer, default: 0
  end
end
