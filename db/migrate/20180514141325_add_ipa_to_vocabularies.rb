class AddIpaToVocabularies < ActiveRecord::Migration[5.2]
  def change
    add_column :vocabularies, :ipa, :string
  end
end
