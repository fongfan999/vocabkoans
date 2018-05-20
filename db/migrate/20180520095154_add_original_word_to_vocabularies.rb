class AddOriginalWordToVocabularies < ActiveRecord::Migration[5.2]
  def change
    add_column :vocabularies, :original_word, :string
  end
end
