class CreateVocabularies < ActiveRecord::Migration[5.2]
  def change
    create_table :vocabularies do |t|
      t.string :word
      t.string :word_class
      t.jsonb  :sense, null: false, default: '{}'
    end
  end
end
