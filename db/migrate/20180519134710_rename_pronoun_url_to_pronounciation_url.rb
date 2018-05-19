class RenamePronounUrlToPronounciationUrl < ActiveRecord::Migration[5.2]
  def change
    rename_column :vocabularies, :pronoun_url, :pronunciation_url
  end
end
