class AddIndexToWordFromVocabularies < ActiveRecord::Migration[5.2]
  def change
    add_index :vocabularies, :word
  end
end
