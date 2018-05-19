class AddPronounUrlToVocabularies < ActiveRecord::Migration[5.2]
  def change
    add_column :vocabularies, :pronoun_url, :string
  end
end
